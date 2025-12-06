import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mc_hub/pages/deviceSelect_page/deviceSelect_page.dart';
import 'package:mc_hub/pages/editor_page/editor_page.dart';
import 'package:mc_hub/theme/custom_theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: CustomTheme().darkTheme,
      initialRoute: AppRoute.deviceSelect.path,
      routes: {
        AppRoute.deviceSelect.path: (context) => const DeviceSelectPage(),
        AppRoute.editor.path: (context) => const EditorPage(),
      },
    );
  }
}

enum AppRoute {
  deviceSelect("/deviceSelect"),
  editor("/editor");

  const AppRoute(this.path);
  final String path;
}
