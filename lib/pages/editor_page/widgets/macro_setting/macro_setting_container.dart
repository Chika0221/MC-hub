// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MacroSettingContainer extends HookConsumerWidget {
  const MacroSettingContainer({
    super.key,
    required this.title,
    required this.selected,
    required this.onAttach,
    required this.itemCount,
    required this.builder,
  });

  final String title;
  final int? selected;
  final int itemCount;
  final Widget Function(int index) builder;
  final void Function(String docId, int index) onAttach;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(itemCount, (index) {
                  return InkWell(
                    onTap: () => onAttach("docId_$index", index),
                    child: builder(index),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MacroSelecterContainer extends HookConsumerWidget {
  MacroSelecterContainer({
    super.key,
    required this.select,
    required this.title,
    this.subtitle,
  });

  final bool select;
  final String title;
  String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        color:
            (select)
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color:
                        (select)
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  subtitle ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        (select)
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          if (select)
            IconButton.filled(icon: Icon(Icons.check), onPressed: () {}),
        ],
      ),
    );
  }
}
