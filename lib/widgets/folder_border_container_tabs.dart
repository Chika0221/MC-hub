// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/folder_border_containar.dart';

class FolderBorderContainerTabs extends HookConsumerWidget {
  const FolderBorderContainerTabs({
    super.key,
    required this.children,
    required this.titles,
    required this.backgroundColor,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final Color backgroundColor;
  final List<String> titles;
  final List<Widget> children;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double titletabHeight = 32;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: titletabHeight,
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(children.length, (int index) {
              if (index == selectedIndex) {
                return TabTitle(
                  backgroundColor: backgroundColor,
                  title: titles[index],
                );
              } else {
                return GestureDetector(
                  onTap: () => onTabChanged.call(index),
                  child: TabTitle(
                    backgroundColor: backgroundColor.withAlpha(
                      (255 * backgroundColor.a * 0.5).toInt(),
                    ),
                    title: titles[index],
                  ),
                );
              }
            }),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: children[selectedIndex],
          ),
        ),
      ],
    );
  }
}

class TabTitle extends StatelessWidget {
  const TabTitle({
    super.key,
    required this.backgroundColor,
    required this.title,
  });

  final Color backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
