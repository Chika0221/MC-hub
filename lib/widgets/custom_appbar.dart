import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          Expanded(
            child: WindowTitleBarBox(
              child: MoveWindow(
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 4),
                    Text("MC Hub"),
                  ],
                ),
              ),
            ),
          ),
          MinimizeWindowButton(colors: buttonColors),
          MaximizeWindowButton(colors: buttonColors),
          CloseWindowButton(colors: closeButtonColors),
        ],
      ),
    );
  }
}
