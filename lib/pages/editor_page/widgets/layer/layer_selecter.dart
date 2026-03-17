// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LayerSelecter extends HookConsumerWidget {
  const LayerSelecter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          child: FilledButton.tonal(
            onPressed: () {},
            child: Text("Profile $index"),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemCount: 20,
    );
  }
}
