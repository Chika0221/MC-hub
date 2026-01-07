// Project imports:
import 'package:mc_hub/infrastructure/providers/vial_provider.dart';

class MacroService {
  final MonitorKeycodes keycode;

  MacroService({required this.keycode});

  void runMacro() {
    switch (keycode) {
      case MonitorKeycodes.macro1:
        print("Running Macro 1");
        // final hit = VialKey.fromLabel("Space");

        // final sendCode = (hit!.code >> 8) + 0x3D;

        // print("Hit: 0x${hit!.code.toRadixString(16)}");
        // print("Semd: 0x${sendCode.toRadixString(16)}");

        // Add your macro logic here
        break;
      case MonitorKeycodes.macro2:
        print("Running Macro 2");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro3:
        print("Running Macro 3");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro4:
        print("Running Macro 4");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro5:
        print("Running Macro 5");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro6:
        print("Running Macro 6");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro7:
        print("Running Macro 7");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro8:
        print("Running Macro 8");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro9:
        print("Running Macro 9");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro10:
        print("Running Macro 10");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro11:
        print("Running Macro 11");
        // Add your macro logic here
        break;
      case MonitorKeycodes.macro12:
        print("Running Macro 12");
        // Add your macro logic here
        break;
    }
  }
}

enum MonitorKeycodes {
  macro1(0x7C),
  macro2(0x7D),
  macro3(0x7E),
  macro4(0x7F),
  macro5(0x80),
  macro6(0x81),
  macro7(0x82),
  macro8(0x83),
  macro9(0x84),
  macro10(0x85),
  macro11(0x86),
  macro12(0x87);

  final int vkCode;
  const MonitorKeycodes(this.vkCode);
}
