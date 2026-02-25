// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_connect_stream_provider.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class ConnectStateContainer extends HookConsumerWidget {
  const ConnectStateContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final connectStream = ref.watch(firebaseConnectStreamProvider);

    return DoubleLineBorderContainer(
      child: Container(
        height: 64,
        width: 128,
        child: connectStream.when(
          loading:
              () => Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
          error: (error, stackTrace) {
            print(error);
            return Center(
              child: Text(
                "$error",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            );
          },
          data: (connect) {
            return Center(
              child: Text(
                connect.hostName ?? "未接続",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            );
          },
        ),
      ),
      backgroundColor: colorScheme.surfaceContainer,
    );
  }
}
