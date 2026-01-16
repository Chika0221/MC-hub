// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

// Project imports:
import 'package:mc_hub/firebase_options.dart';
import 'package:mc_hub/infrastructure/hooks/keyboard_hooks.dart';
import 'package:mc_hub/infrastructure/hooks/virtual_key_codes.dart';
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/pages/editor_page/editor_page.dart';
import 'package:mc_hub/pages/home_page/home_page.dart';
import 'package:mc_hub/tasktray/tasktray.dart';
import 'package:mc_hub/theme/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await RiveNative.init();

  runApp(ProviderScope(child: TaskTray(child: MyApp())));

  doWhenWindowReady(() {
    // const initialSize = Size(600, 450);
    // appWindow.minSize = initialSize;
    // appWindow.size = initialSize;
    appWindow.show();
  });
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastLog = useState(0);

    useEffect(() {
      final monitor = KeyboardMonitor(
        onKeyDetected: (event) {
          final log =
              "0x${event.vkCode.toRadixString(16).padLeft(2, '0').toUpperCase()} SCAN: ${event.scanCode}";
          lastLog.value = event.vkCode;

          print(VirtualKeyCode.tryFromVkCode(event.vkCode)?.name);

          if (MonitorKeycodes.macro1.vkCode <= lastLog.value &&
              lastLog.value <= MonitorKeycodes.macro12.vkCode) {
            final macroService = MacroService(
              keycode: MonitorKeycodes.values.firstWhere(
                (kc) => kc.vkCode == lastLog.value,
              ),
            );
            macroService.runMacro();
          }
        },
      );

      monitor.start();

      return () {
        monitor.stop();
      };
    }, []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: "MC Hub",
      theme: CustomTheme().mainLightTheme,
      darkTheme: CustomTheme().mainDarkTheme,
      initialRoute: AppRoute.home.path,
      routes: {
        AppRoute.editor.path: (context) => const EditorPage(),
        AppRoute.home.path: (context) => const HomePage(),
      },
    );
  }
}

enum AppRoute {
  editor("/editor"),
  home("/home");

  const AppRoute(this.path);
  final String path;
}
