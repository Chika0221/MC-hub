// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tray_manager/tray_manager.dart';

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
      await trayManager.setIcon("assets/icons/tray_icon.ico");
      await trayManager.setToolTip("MCHub");
      await trayManager.setContextMenu(
        Menu(
          items: [
            MenuItem(key: 'show', label: 'MCHubを開く'),
            MenuItem(key: 'exit', label: '閉じる'),
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
    if (menuItem.key == 'show') {
      appWindow.show();
    } else if (menuItem.key == 'exit') {
      appWindow.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
