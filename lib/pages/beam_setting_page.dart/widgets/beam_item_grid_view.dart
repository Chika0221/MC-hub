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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: childrenAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
