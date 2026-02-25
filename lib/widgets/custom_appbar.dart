// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/app_shutdown.dart';
import 'package:mc_hub/main.dart';
import 'package:mc_hub/widgets/custom_appbar_back_icon.dart';

class CustomAppbar extends HookConsumerWidget implements PreferredSizeWidget {
  CustomAppbar({super.key, this.title, this.returnValue = null});

  final String? title;
  final dynamic returnValue;

  @override
  final Size preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonColors = WindowButtonColors(
      iconNormal: Theme.of(context).colorScheme.secondary,
      mouseOver: Theme.of(context).colorScheme.primaryContainer,
      mouseDown: Theme.of(context).colorScheme.secondaryContainer,
      iconMouseOver: Theme.of(context).colorScheme.onPrimaryContainer,
      iconMouseDown: Theme.of(context).colorScheme.onSecondaryContainer,
    );

    final closeButtonColors = WindowButtonColors(
      mouseOver: Theme.of(context).colorScheme.error,
      mouseDown: Theme.of(context).colorScheme.error,
      iconNormal: Theme.of(context).colorScheme.secondary,
      iconMouseOver: Theme.of(context).colorScheme.onError,
    );

    return Container(
      child: Stack(
        children: [
          if (title != null)
            Positioned.fill(
              child: Center(
                child: Text(
                  title!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          Row(
            children: [
              if (ModalRoute.of(context)?.settings.name != AppRoute.home.path)
                WindowButton(
                  colors: buttonColors,
                  iconBuilder:
                      (WindowButtonContext context) =>
                          CustomBackIcon(color: context.iconColor),
                  onPressed: () {
                    Navigator.of(context).pop(returnValue);
                  },
                ),
              Expanded(child: WindowTitleBarBox(child: MoveWindow())),
              MinimizeWindowButton(colors: buttonColors),
              appWindow.isMaximized
                  ? RestoreWindowButton(colors: buttonColors)
                  : MaximizeWindowButton(colors: buttonColors),
              CloseWindowButton(
                colors: closeButtonColors,
                onPressed: () {
                  final alertDialog = AlertDialog(
                    title: Text("ソフトを終了しますか？"),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          appWindow.hide();
                          Navigator.of(context).pushNamed(AppRoute.home.path);
                        },
                        child: Text("タスクトレイに収納"),
                      ),
                      FilledButton.tonal(
                        onPressed: () {
                          unawaited(shutdownAndExit(ref));
                        },
                        child: Text("ソフトを終了"),
                      ),
                    ],
                  );

                  showDialog(
                    context: context,
                    builder: (context) => alertDialog,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
