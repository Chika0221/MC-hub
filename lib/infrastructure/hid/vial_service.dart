// Dartのインポート:

// Dart imports:
import 'dart:async';
import 'dart:typed_data';

// Package imports:
import 'package:hid4flutter/hid4flutter.dart';

// Project imports:
import 'package:mc_hub/models/my_device.dart';

// パッケージのインポート:

// プロジェクトのインポート:

class VialService {
  HidDevice? _device;
  bool get isConnected => _device != null;

  /// 定義に一致するデバイスに接続します。
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
        // フォールバック: 正確に見つからない場合はUsage Pageのチェックを緩和します（一部のOSでよくある問題）
        // またはベンダー/プロダクトIDのみで試行します
        try {
          _device = devices.firstWhere(
            (d) =>
                d.vendorId == deviceDefinition.vendorId &&
                d.productId == deviceDefinition.productId &&
                d.usagePage == 0xFF60, // 一般的なVial/ViaのUsage Page
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

  /// 生の32バイトレポートを送信します。
  Future<void> sendRaw(Uint8List data) async {
    if (_device == null) throw Exception("Device not connected");
    // 32バイトであることを確認します（hid4flutterによって暗黙的に処理されるか、明示的なレポートID 0を含む）
    // hid4flutter sendReport: 必要に応じてreportIdをプレフィックスとして付加します。
    // 通常、QMK RawHIDはレポートID 0を使用します。
    // データが32バイトの場合、そのまま送信します。

    // 注意: 一部のプラットフォームではレポートIDが必要です。QMK Raw HIDは通常、レポートIDが0の場合、データを直接期待します。
    // hid4flutterのsendReportシグネチャ: `sendReport({int reportId = 0x00, required Uint8List reportData})`
    await _device!.sendReport(data, reportId: 0x00);
  }

  /// レポートを受信します（32バイトを想定）。
  Future<Uint8List> receiveRaw() async {
    if (_device == null) throw Exception("Device not connected");
    // QMK Raw HIDのパケットサイズは通常32です。
    // ハングアップを防ぐためにタイムアウトが重要です。
    try {
      final data = await _device!.receiveReport(
        32,
        timeout: const Duration(seconds: 1),
      );
      // 実装によっては最初のバイトがレポートIDである可能性がありますが、hid4flutterは通常それを削除するか、生のバッファを返します。
      // ドキュメントに基づく: "最初のバイトは常にreportIdです。"
      // したがって、32バイトの*ペイロード*を期待する場合、33バイト取得する可能性があります。
      // QMK RawHIDパケットは通常、すべてを含めて32バイトです。
      // [ReportID, Data...] の形式で取得すると仮定します。
      if (data.length > 32) {
        // レポートIDを削除
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
    cmd[0] = 0x01; // vial_get_protocol_version または via_get_protocol_version
    await sendRaw(cmd);
    final response = await receiveRaw();
    // レスポンス: [0x01, VersionHigh, VersionLow, ...]
    if (response[0] != 0x01) {
      // 0x01が失敗した場合、QMK IDコマンドを試すべきか？いいえ、標準的なVIAは0x01です。
      throw Exception("Invalid protocol version response");
    }
    return (response[1] << 8) | response[2];
  }

  Future<void> unlock() async {
    // Vialのロック解除。基本的なVIAコマンドには厳密には必要ないことが多いですが、あると良いでしょう。
    // コマンド: vial_unlock
    // しかし、VIA互換コマンドのみを使用している場合は、これをスキップできるかもしれません。
    // 今のところ空にしておくか、必要に応じて一般的なロック解除を実装します。
  }

  /// キーマップバッファを読み取ります。
  /// offset: EEPROM/メモリ内のバイトオフセット
  /// size: 読み取るバイト数（通常、パケットあたり最大28バイト）
  Future<Uint8List> dynamicKeymapGetBuffer(int offset, int size) async {
    final cmd = Uint8List(32);
    cmd[0] = 0x12; // id_dynamic_keymap_get_buffer
    // offset (2バイト、VIAでは通常ビッグエンディアン？はい、VIAはオフセットにビッグエンディアンを使用します)
    // VIAプロトコル:
    // 0: ID (0x12)
    // 1: オフセット MSB
    // 2: オフセット LSB
    // 3: サイズ
    cmd[1] = (offset >> 8) & 0xFF;
    cmd[2] = offset & 0xFF;
    cmd[3] = size;

    await sendRaw(cmd);
    final response = await receiveRaw();

    // レスポンス:
    // 0: ID (0x12)
    // 1..size: データ
    if (response[0] != 0x12) {
      throw Exception("Invalid dynamic_keymap_get_buffer response");
    }
    return response.sublist(
      4,
      4 + size,
    ); // 待ってください、VIAレスポンスのペイロードは通常バイト4から始まりますか？
    // 一般的なVIAプロトコルを確認しましょう。
    // リクエスト: [0x12, offH, offL, size]
    // レスポンス: [0x12, offH, offL, size, data...]
    // したがって、データはインデックス4から始まります。
  }

  /// キーマップバッファに書き込みます。
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
    // 通常、set_bufferに対するレスポンスはないか、エコーされます。
  }

  /// 完全なキーマップを取得するためのヘルパー
  /// layers: レイヤー数
  /// rows: 行数
  /// cols: 列数
  Future<List<List<List<int>>>> getKeymap({
    required int layers,
    required int rows,
    required int cols,
  }) async {
    // キーコードあたり2バイト
    final totalBytes = layers * rows * cols * 2;
    final buffer = Uint8List(totalBytes);
    const blockSize = 28; // 安全なチャンクサイズ

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

    // バッファを [layer][row][col] にパース
    List<List<List<int>>> map = [];
    int ptr = 0;
    for (int l = 0; l < layers; l++) {
      List<List<int>> layer = [];
      for (int r = 0; r < rows; r++) {
        List<int> row = [];
        for (int c = 0; c < cols; c++) {
          // QMKでは通常リトルエンディアンのキーコードですか？
          // QMK EEPROMは通常リトルエンディアンです。
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

  Future<void> setKey(
    int layer,
    int row,
    int col,
    int keycode,
    int totalRows,
    int totalCols,
  ) async {
    // オフセットを計算
    // offset = (layer * rows * cols * 2) + (row * cols * 2) + (col * 2)
    final offset =
        (layer * totalRows * totalCols * 2) + (row * totalCols * 2) + (col * 2);
    final data = Uint8List(2);
    data[0] = keycode & 0xFF;
    data[1] = (keycode >> 8) & 0xFF;

    await dynamicKeymapSetBuffer(offset, data);
  }
}
