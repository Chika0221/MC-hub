// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/double_line_border_container.dart';

class ConnectStateContainer extends HookConsumerWidget {
  const ConnectStateContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return DoubleLineBorderContainer(
      child: Container(
        height: 64,
        width: 128,
        child: const Center(
          child: Text(
            "接続状態",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: colorScheme.surfaceContainer,
    );
  }
}
