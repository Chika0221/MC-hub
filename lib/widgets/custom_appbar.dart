// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/main.dart';
import 'package:mc_hub/theme/custom_theme.dart';

class CustomAppbar extends HookConsumerWidget {
  const CustomAppbar({super.key});
  @override
  PreferredSizeWidget build(BuildContext context, WidgetRef ref) {
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

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Row(
        children: [
          if (ModalRoute.of(context)?.settings.name !=
              AppRoute.deviceSelect.path)
            WindowButton(
              iconBuilder:
                  (WindowButtonContext context) => Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          Expanded(
            child: WindowTitleBarBox(
              child: MoveWindow(
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "MC Hub",
                      style: TextStyle(fontFamily: Fonts.LunaChord.name),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                      Navigator.of(
                        context,
                      ).pushNamed(AppRoute.deviceSelect.path);
                    },
                    child: Text("タスクトレイに収納"),
                  ),
                  OutlinedButton(
                    onPressed: () => appWindow.close(),
                    child: Text("ソフトを終了"),
                  ),
                ],
              );

              showDialog(context: context, builder: (context) => alertDialog);
            },
          ),
        ],
      ),
    );
  }
}
