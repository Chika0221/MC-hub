// Project imports:

// Dart imports:
import 'dart:io';

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

          await firebaseNotifier.updateCodes(updateCode);

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
            final result = await Process.run("powershell", [
              "start",
              "\"${appPath}\"",
            ], runInShell: true);

            print('Exit Code: ${result.exitCode}');
            print('stderr: ${result.stderr}');
            print('stdout: ${result.stdout}');
          }

          break;

        case MacroType.aiTextConvert:
          final aiPrompt = macro.aiPrompt;
          if (aiPrompt != null) {
            


          }

          break;
      }

      sendNotification("マクロ実行完了", "マクロ「${macro.name}」を実行しました");
    } else {
      sendNotification("マクロが登録されていません", "アプリを開いてマクロを設定してください");
    }
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
