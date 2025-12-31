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
    this.floatingActionButton = const SizedBox.shrink(),
  });

  final Color backgroundColor;
  final String title;
  final Widget child;
  final Widget floatingActionButton;

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
                      top: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "コード一覧",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(-1, 0),
                        child: Container(
                          width: 128,
                          height: titletabHeight,
                          color: backgroundColor,
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1, 0),
                        child: Container(
                          width: 300,
                          height: titletabHeight,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
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
            child: Stack(
              children: [
                Positioned.fill(
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
                    child: child,
                  ),
                ),
                Positioned(right: 16, bottom: 16, child: floatingActionButton),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
