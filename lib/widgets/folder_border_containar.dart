// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FolderBorderContainar extends HookConsumerWidget {
  const FolderBorderContainar({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.child,
  });

  final Color backgroundColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double titletabHeight = 48;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: titletabHeight,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "タイトルである",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 64,
                          height: titletabHeight,
                          color: backgroundColor,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 64,
                          height: titletabHeight,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Expanded(child: child),
            ),
          ),
        ],
      ),
    );
  }
}
