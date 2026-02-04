// Package imports:
import 'package:hid4flutter/hid4flutter.dart';

// Project imports:
import 'package:mc_hub/infrastructure/hid/list_of_mydevices.dart';

List<HidDevice> filterMyKeyboards(List<HidDevice> devices) {
  return devices
      .where(
        (device) => myDevices.any((myDevice) {
          return device.vendorId == myDevice.vendorId &&
              device.productId == myDevice.productId &&
              device.usagePage == myDevice.usegePage &&
              device.usage == myDevice.usege;
        }),
      )
      .toList();
}

Future<List<HidDevice>> deviceList() async {
  final devices = await Hid.getDevices();
  // print(devices);
  final keyboards = filterMyKeyboards(devices);
  print(keyboards);

  return keyboards;
}

// class VialKeyboardService {
//   // ターゲットとするキーボードのID（ご自身のキーボードに合わせて変更してください）
//   final int vendorId = 0xFEED; // 例: QMKデフォルトなど
//   final int productId = 0x6060; // 例: キーボード固有ID

//   // Vial/QMKのRaw HID Usage Page
//   final int usagePage = 0xFF60;
//   final int usage = 0x61;

//   HidDevice? _device;

//   /// キーボードに接続する
//   Future<bool> connect() async {
//     try {
//       final devices = await Hid.getDevices();

//       // VID, PID, そしてUsagePageが一致するデバイスを探す（重要）
//       // ※通常のキー入力インターフェースとRaw HIDインターフェースを区別するためです
//       final targetDevice = devices.firstWhere(
//         (d) => d.vendorId == vendorId &&
//                d.productId == productId &&
//                d.usagePage == usagePage,
//       );

//       _device = targetDevice;
//       await _device!.open();
//       print("デバイスに接続しました: ${_device!.productName}");
//       return true;
//     } catch (e) {
//       print("デバイスが見つかりません: $e");
//       return false;
//     }
//   }

//   /// Vialプロトコルバージョンを取得する（接続テスト）
//   Future<void> getVialProtocolVersion() async {
//     if (_device == null) return;

//     // Vialコマンド: vial_get_keyboard_id (ID取得とプロトコル確認)
//     // コマンドID: 0x00
//     // 通常32バイトのバッファを作成
//     Uint8List command = Uint8List(32);
//     command[0] = 0x00; // vial_get_keyboard_id command

//     try {
//       // 1. コマンド送信
//       await _device!.sendReport(command);

//       // 2. レスポンス受信（非同期ストリームまたはRead）
//       // hid4flutterの仕様により、listenで待ち受けるのが一般的です
//       _device!.inputStream.listen((data) {
//         // レスポンスの解析
//         // byte 0-1: Vial Protocol Version
//         // byte 2-7: Keyboard UID
//         final protocolVersion = data[0] | (data[1] << 8);
//         print("Vial Protocol Version: $protocolVersion");

//         // ここで必要なデータをパースしてUIに返します
//       });

//     } catch (e) {
//       print("通信エラー: $e");
//     }
//   }

//   void dispose() {
//     _device?.close();
//   }
// }
