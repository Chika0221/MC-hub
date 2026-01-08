// Project imports:

// Project imports:
import 'package:mc_hub/infrastructure/macro/app_preferences.dart';
import 'package:mc_hub/infrastructure/notification/send_notification.dart';
import 'package:mc_hub/infrastructure/providers/firebase_codes_stream_privider.dart';
import 'package:mc_hub/models/macro.dart';

class MacroService {
  final MonitorKeycodes keycode;

  MacroService({required this.keycode});

  void runMacro() async {
    final Macro? macro = await AppPreferences.getMacro(keycode);

    if (macro != null) {
      switch (macro.type) {
        case MacroType.infrared:
          final firebaseNotifier = FirebaseCodesStreamNotifier();
          final inCode = await firebaseNotifier.getCode(macro.docId!);

          final updateCode = inCode.copyWith(state: true);

          firebaseNotifier.updateCodes(updateCode);

        case MacroType.combo:
          print("Executing Combo Macro: ${macro.name}");
          sendNotification(
            "Macro Executed",
            "Executed Combo Macro: ${macro.name}",
          );
          break;
        case MacroType.openApp:
          final appPath = macro.appPath;
          if (appPath != null) {
            print("Opening Application at path: $appPath");
            sendNotification(
              "Macro Executed",
              "Opened Application at path: $appPath",
            );
          }
          break;
      }

      sendNotification("マクロ実行完了", "マクロ「${macro.name}」を実行しました");
    } else {
      sendNotification("マクロが登録されていません", "アプリを開いてマクロを設定してください");
    }

    // switch (keycode) {
    //   case MonitorKeycodes.macro1:
    //     print("Running Macro 1");
    //     // final hit = VialKey.fromLabel("Space");

    //     // final sendCode = (hit!.code >> 8) + 0x3D;

    //     // print("Hit: 0x${hit!.code.toRadixString(16)}");
    //     // print("Semd: 0x${sendCode.toRadixString(16)}");

    //     // If using Riverpod, you'll need access to the provider's notifier instance.

    //     break;
    //   case MonitorKeycodes.macro2:
    //     print("Running Macro 2");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro3:
    //     print("Running Macro 3");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro4:
    //     print("Running Macro 4");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro5:
    //     print("Running Macro 5");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro6:
    //     print("Running Macro 6");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro7:
    //     print("Running Macro 7");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro8:
    //     print("Running Macro 8");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro9:
    //     print("Running Macro 9");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro10:
    //     print("Running Macro 10");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro11:
    //     print("Running Macro 11");
    //     // Add your macro logic here
    //     break;
    //   case MonitorKeycodes.macro12:
    //     print("Running Macro 12");
    //     // Add your macro logic here
    //     break;
    // }
  }
}

enum MonitorKeycodes {
  macro1(0x7C, "M1"),
  macro2(0x7D, "M2"),
  macro3(0x7E, "M3"),
  macro4(0x7F, "M4"),
  macro5(0x80, "M5"),
  macro6(0x81, "M6"),
  macro7(0x82, "M7"),
  macro8(0x83, "M8"),
  macro9(0x84, "M9"),
  macro10(0x85, "M10"),
  macro11(0x86, "M11"),
  macro12(0x87, "M12");

  final int vkCode;
  final String shortName;
  const MonitorKeycodes(this.vkCode, this.shortName);
}
