// Flutter imports:

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

// Project imports:
import 'package:mc_hub/firebase_options.dart';
import 'package:mc_hub/infrastructure/providers/firebase_connect_stream_provider.dart';
import 'package:mc_hub/infrastructure/providers/keyboard_monitor_controller_provider.dart';
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
    useEffect(() {
      if (kDebugMode) {
        return null;
      }

      unawaited(ref.read(keyboardMonitorControllerProvider).start());

      return () {
        ref.read(keyboardMonitorControllerProvider).stop();
        unawaited(ref.read(firebaseConnectStreamProvider.notifier).close());
      };
    }, const []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: "SwitchPalette",
      theme: CustomTheme().mainLightTheme,
      darkTheme: CustomTheme().mainDarkTheme,
      // initialRoute: AppRoute.home.path,
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
