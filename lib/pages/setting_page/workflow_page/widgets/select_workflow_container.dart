// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectWorkflowContainer extends HookConsumerWidget {
  const SelectWorkflowContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(width: 380, child: Container(color: Colors.blue));
  }
}
