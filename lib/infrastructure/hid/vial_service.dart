// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Package imports:
import 'package:hid4flutter/hid4flutter.dart';

class VialService {
  HidDevice? _device;
  bool get isConnected => _device != null;

  Future<bool> connect(HidDevice device) async {
    final devices = await Hid.getDevices();
    try {
      try {
        _device = devices.firstWhere(
          (d) =>
              d.vendorId == device.vendorId &&
              d.productId == device.productId &&
              d.usagePage == device.usagePage &&
              d.usage == device.usage,
        );
      } catch (e) {
        try {
          _device = devices.firstWhere(
            (d) =>
                d.vendorId == device.vendorId &&
                d.productId == device.productId,
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

  Future<void> sendRaw(Uint8List data) async {
    if (_device == null) throw Exception("Device not connected");
    await _device!.sendReport(data, reportId: 0x00);
  }

  Future<Uint8List> receiveRaw() async {
    if (_device == null) throw Exception("Device not connected");

    try {
      final data = await _device!.receiveReport(
        32,
        timeout: const Duration(seconds: 1),
      );

      if (data.length > 32) {
        return data.sublist(1);
      }
      if (data.length == 33 && data[0] == 0) {
        return data.sublist(1);
      }
      return data;
    } catch (e) {
      throw Exception("Receive failed: $e");
    }
  }

  Future<int> getProtocolVersion() async {
    final command = Uint8List(32);

    command[0] = 0x01;
    await sendRaw(command);
    final response = await receiveRaw();

    if (response[0] != 0x01) {
      throw Exception("Invalid response for protocol version");
    }

    return (response[1] << 8) | response[2];
  }

  Future<Uint8List> dynamicKeymapGetBuffer(int offset, int size) async {
    final command = Uint8List(32);
    command[0] = 0x12;
    command[1] = (offset >> 8) & 0xFF;
    command[2] = offset & 0xFF;
    command[3] = size;

    await sendRaw(command);
    final response = await receiveRaw();

    if (response[0] != 0x12) {
      throw Exception("Invalid response for dynamic keymap get buffer");
    }

    return response.sublist(4, 4 + size);
  }

  Future<void> dynamicKeymapSetBuffer(int offset, Uint8List data) async {
    if (data.length > 28) {
      throw Exception("Data too long for single packet");
    }

    final command = Uint8List(32);
    command[0] = 0x13;
    command[1] = (offset >> 8) & 0xFF;
    command[2] = offset & 0xFF;
    command[3] = data.length;

    for (int i = 0; i < data.length; i++) {
      command[4 + i] = data[i];
    }

    await sendRaw(command);
  }

  Future<List<List<List<int>>>> getKeymap({
    required int layers,
    required int rows,
    required int cols,
  }) async {
    final totalBytes = layers * rows * cols * 2;
    final buffer = Uint8List(totalBytes);
    const blockSize = 28;

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

    List<List<List<int>>> keymap = [];
    int ptr = 0;

    for (int l = 0; l < layers; l++) {
      List<List<int>> layer = [];
      for (int r = 0; r < rows; r++) {
        List<int> row = [];
        for (int c = 0; c < cols; c++) {
          final keycode = buffer[ptr] | (buffer[ptr + 1] << 8);
          row.add(keycode);
          ptr += 2;
        }
        layer.add(row);
      }
      keymap.add(layer);
    }
    return keymap;
  }

  Future<void> setKey(
    int layer,
    int row,
    int col,
    int keycode,
    int totalRows,
    int totalCols,
  ) async {
    final offset =
        (layer * totalRows * totalCols * 2) + (row * totalCols * 2) + (col * 2);
    final data = Uint8List(2);
    data[0] = keycode & 0xFF;
    data[1] = (keycode >> 8) & 0xFF;

    await dynamicKeymapSetBuffer(offset, data);
  }
}
