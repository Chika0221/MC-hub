// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BeamItemGridView extends HookConsumerWidget {
  const BeamItemGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.childrenAspectRatio,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double childrenAspectRatio;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisExtent: 80.0,
        maxCrossAxisExtent: 400.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 4 / 1,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
