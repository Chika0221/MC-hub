// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_watcher/get_windows/window.dart';
import 'package:window_watcher/window_watcher.dart';

class TaskTray extends StatefulHookConsumerWidget {
  const TaskTray({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskTrayState();
}

class _TaskTrayState extends ConsumerState<TaskTray> with TrayListener {
  final trayManager = TrayManager.instance;

  @override
  void initState() {
    unawaited(() async {
      await trayManager.setIcon("assets/icons/tray_icon.png");
      await trayManager.setToolTip("MC Hub");
      await trayManager.setContextMenu(
        Menu(
          items: [
            MenuItem(key: 'show', label: 'Show App'),
            MenuItem(
              icon: "assets/icons/tray_icon.png",
              key: 'exit',
              label: '閉じる',
            ),
          ],
        ),
      );
      trayManager.addListener(this);
    }());
    super.initState();
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  void onTrayMenuItemClick(MenuItem menuItem) async {
    final List<Window> windows = await WindowWatcher.getWindows(getExe: true);
    final mcHubWindow = windows.firstWhere(
      (window) => window.title.contains("mc_hub"),
    );

    if (menuItem.key == 'show') {
      // Handle showing the app
      print("いえい");
      mcHubWindow.show(forced: true);
    } else if (menuItem.key == 'exit') {
      // Handle exiting the app
      print("ばいばい");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
