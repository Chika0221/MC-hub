// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LayerButton extends HookConsumerWidget {
  const LayerButton({super.key, required this.icon, required this.onPressed});

  final Icon icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
      ),
      icon: icon,
      onPressed: onPressed,
    );
  }
}
