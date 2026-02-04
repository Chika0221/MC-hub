// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
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
  final void Function(int index) onAttach;
  final Widget Function(int index) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8.0),
          Container(
            width: double.maxFinite,
            height: 200,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: GridView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 60.0,
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 4 / 1,
              ),

              itemCount: itemCount,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onAttach(index),
                  child: builder(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MacroSelecterContainer extends HookConsumerWidget {
  const MacroSelecterContainer({
    super.key,
    required this.select,
    required this.title,
    this.subtitle,
  });

  final bool select;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
                  overflow: TextOverflow.ellipsis,
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
