// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BeamItemListView extends HookConsumerWidget {
  const BeamItemListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.backgroundColor,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text("こんにちは"),
            SizedBox(height: 16),
            Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: itemCount,
                itemBuilder: itemBuilder,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
