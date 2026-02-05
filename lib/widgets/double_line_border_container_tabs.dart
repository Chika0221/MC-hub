// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/double_line_border_container.dart';

class DoubleLineBorderContainerTabs extends HookConsumerWidget {
  const DoubleLineBorderContainerTabs({
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
    const double titletabHeight = 38;

    final colorScheme = Theme.of(context).colorScheme;

    return DoubleLineBorderContainer(
      backgroundColor: backgroundColor,
      borderType: DoubleLineBorderType.roundedRectangle,
      borderRadius: 32,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: titletabHeight,
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: colorScheme.secondaryContainer,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(children.length, (int index) {
                  if (index == selectedIndex) {
                    return TabTitle(
                      textColor: colorScheme.onPrimary,
                      backgroundColor: colorScheme.primary,
                      title: titles[index],
                    ).animate().slideY(begin: -0.1, end: 0.0, duration: 100.ms);
                  } else {
                    return GestureDetector(
                      onTap: () => onTabChanged.call(index),
                      child: TabTitle(
                        textColor: colorScheme.surface,
                        backgroundColor: Colors.transparent,
                        title: titles[index],
                      ),
                    );
                  }
                }),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: children[selectedIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabTitle extends StatelessWidget {
  const TabTitle({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    required this.title,
  });

  final Color backgroundColor;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
