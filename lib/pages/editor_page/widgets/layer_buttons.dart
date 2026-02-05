// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LayerButtons extends HookConsumerWidget {
  const LayerButtons({
    super.key,
    required this.selectedLayerIndex,
    required this.onLayerChanged,
  });

  final int selectedLayerIndex;
  final ValueChanged<int> onLayerChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          const SizedBox(height: 8),
          ...List.generate(4, (index) {
            return LayerButton(
              child: Text(
                index.toString(),
                style: TextStyle(
                  color:
                      (selectedLayerIndex == index)
                          ? Theme.of(context).colorScheme.onTertiary
                          : Theme.of(context).colorScheme.surface,
                ),
              ),
              onPressed: () => onLayerChanged.call(index),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class LayerButton extends HookConsumerWidget {
  const LayerButton({super.key, required this.child, required this.onPressed});

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
      ),
      icon: child,
      onPressed: onPressed,
    );
  }
}
