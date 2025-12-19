import 'dart:async';
import 'dart:typed_data';

import 'package:hid4flutter/hid4flutter.dart';
import 'package:mc_hub/models/my_device.dart';

class VialService {
  HidDevice? _device;
  bool get isConnected => _device != null;

  /// Connects to a device matching the definitions.
  Future<bool> connect(MyDevice deviceDefinition) async {
    try {
      final devices = await Hid.getDevices();
      try {
        _device = devices.firstWhere(
          (d) =>
              d.vendorId == deviceDefinition.vendorId &&
              d.productId == deviceDefinition.productId &&
              d.usagePage == deviceDefinition.usegePage &&
              d.usage == deviceDefinition.usege,
        );
      } catch (e) {
        // Fallback: relax usage page check if not found exactly (common issue on some OS)
        // or just try vendor/product
        try {
           _device = devices.firstWhere(
            (d) =>
                d.vendorId == deviceDefinition.vendorId &&
                d.productId == deviceDefinition.productId &&
                d.usagePage == 0xFF60, // Common Vial/Via usage page
          );
        } catch (_) {
          return false;
        }
      }

      if (_device != null) {
        await _device!.open();
        return true;
      }
      return false;
    } catch (e) {
      print("Connection failed: $e");
      return false;
    }
  }

  void disconnect() {
    _device?.close();
    _device = null;
  }

  /// Sends a raw 32-byte report.
  Future<void> sendRaw(Uint8List data) async {
    if (_device == null) throw Exception("Device not connected");
    // Ensure 32 bytes (plus report ID 0 implicitly handled by hid4flutter often, or explicit)
    // hid4flutter sendReport: prefix with reportId if needed.
    // Usually QMK RawHID uses report ID 0.
    // If data is 32 bytes, we send it.

    // Note: Some platforms need report ID. QMK Raw HID usually expects the data directly if report ID is 0.
    // hid4flutter `sendReport` signature: `sendReport({int reportId = 0x00, required Uint8List reportData})`
    await _device!.sendReport(reportId: 0x00, reportData: data);
  }

  /// Receive a report (expecting 32 bytes).
  Future<Uint8List> receiveRaw() async {
    if (_device == null) throw Exception("Device not connected");
    // QMK Raw HID packet size is usually 32.
    // Timeout is important to avoid hanging.
    try {
      final data = await _device!.receiveReport(32, timeout: const Duration(seconds: 1));
      // First byte might be report ID depending on implementation, but hid4flutter usually strips it or returns the raw buffer.
      // Based on docs: "First byte is always the reportId."
      // So if we expect 32 bytes of *payload*, we might get 33 bytes?
      // QMK RawHID packet is 32 bytes including everything usually.
      // Let's assume we get [ReportID, Data...].
      if (data.length > 32) {
        // strip report ID
        return data.sublist(1);
      }
      if (data.length == 33 && data[0] == 0) {
          return data.sublist(1);
      }
      return data;
    } catch (e) {
      throw Exception("Failed to receive report: $e");
    }
  }

  Future<int> getProtocolVersion() async {
    final cmd = Uint8List(32);
    cmd[0] = 0x01; // vial_get_protocol_version or via_get_protocol_version
    await sendRaw(cmd);
    final response = await receiveRaw();
    // Response: [0x01, VersionHigh, VersionLow, ...]
    if (response[0] != 0x01) {
       // Try QMK ID command if 0x01 fails? No, standard VIA is 0x01.
       throw Exception("Invalid protocol version response");
    }
    return (response[1] << 8) | response[2];
  }

  Future<void> unlock() async {
     // Vial unlock. often not strictly needed for basic VIA commands, but good to have.
     // Command: vial_unlock
     // But wait, if we are just using VIA compatible commands, we might skip this.
     // Let's leave it empty for now or implement generic unlock if requested.
  }

  /// Reads the keymap buffer.
  /// offset: byte offset in the EEPROM/memory
  /// size: number of bytes to read (max 28 per packet usually)
  Future<Uint8List> dynamicKeymapGetBuffer(int offset, int size) async {
    final cmd = Uint8List(32);
    cmd[0] = 0x12; // id_dynamic_keymap_get_buffer
    // offset (2 bytes, big endian usually in VIA? No, VIA uses big endian for offset)
    // VIA Protocol:
    // 0: ID (0x12)
    // 1: offset MSB
    // 2: offset LSB
    // 3: size
    cmd[1] = (offset >> 8) & 0xFF;
    cmd[2] = offset & 0xFF;
    cmd[3] = size;

    await sendRaw(cmd);
    final response = await receiveRaw();

    // Response:
    // 0: ID (0x12)
    // 1..size: data
    if (response[0] != 0x12) {
      throw Exception("Invalid dynamic_keymap_get_buffer response");
    }
    return response.sublist(4, 4 + size); // Wait, VIA response payload usually starts at byte 4?
    // Let's check generic VIA protocol.
    // Request: [0x12, offH, offL, size]
    // Response: [0x12, offH, offL, size, data...]
    // So data starts at index 4.
  }

  /// Writes to the keymap buffer.
  Future<void> dynamicKeymapSetBuffer(int offset, Uint8List data) async {
    if (data.length > 28) throw Exception("Data too long for single packet");

    final cmd = Uint8List(32);
    cmd[0] = 0x13; // id_dynamic_keymap_set_buffer
    cmd[1] = (offset >> 8) & 0xFF;
    cmd[2] = offset & 0xFF;
    cmd[3] = data.length;

    for (int i = 0; i < data.length; i++) {
      cmd[4 + i] = data[i];
    }

    await sendRaw(cmd);
    // Usually no response for set_buffer, or echoed.
  }

  /// Helper to get the full keymap
  /// layers: number of layers
  /// rows: number of rows
  /// cols: number of cols
  Future<List<List<List<int>>>> getKeymap({required int layers, required int rows, required int cols}) async {
    // 2 bytes per keycode
    final totalBytes = layers * rows * cols * 2;
    final buffer = Uint8List(totalBytes);
    const blockSize = 28; // safe chunk size

    for (int offset = 0; offset < totalBytes; offset += blockSize) {
      int size = blockSize;
      if (offset + size > totalBytes) {
        size = totalBytes - offset;
      }
      final chunk = await dynamicKeymapGetBuffer(offset, size);
      for (int i = 0; i < size; i++) {
        buffer[offset + i] = chunk[i];
      }
    }

    // Parse buffer into [layer][row][col]
    List<List<List<int>>> map = [];
    int ptr = 0;
    for (int l = 0; l < layers; l++) {
      List<List<int>> layer = [];
      for (int r = 0; r < rows; r++) {
        List<int> row = [];
        for (int c = 0; c < cols; c++) {
          // Little endian keycodes usually in QMK?
          // QMK EEPROM is usually little endian.
          final keycode = buffer[ptr] | (buffer[ptr + 1] << 8);
          row.add(keycode);
          ptr += 2;
        }
        layer.add(row);
      }
      map.add(layer);
    }
    return map;
  }

  Future<void> setKey(int layer, int row, int col, int keycode, int totalRows, int totalCols) async {
     // Calculate offset
     // offset = (layer * rows * cols * 2) + (row * cols * 2) + (col * 2)
     final offset = (layer * totalRows * totalCols * 2) + (row * totalCols * 2) + (col * 2);
     final data = Uint8List(2);
     data[0] = keycode & 0xFF;
     data[1] = (keycode >> 8) & 0xFF;

     await dynamicKeymapSetBuffer(offset, data);
  }
}
