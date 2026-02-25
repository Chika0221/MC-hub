// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_connect_stream_provider.dart';
import 'package:mc_hub/models/connect.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class ConnectStateContainer extends HookConsumerWidget {
  const ConnectStateContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final connectStream = ref.watch(firebaseConnectStreamProvider);

    return DoubleLineBorderContainer(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: connectStream.when(
            loading:
                () => CircularProgressIndicator(color: colorScheme.primary),
            error: (error, stackTrace) {
              print(error);
              return Text(
                "$error",
                style: TextStyle(fontSize: 16, color: Colors.white),
              );
            },
            data: (connect) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (connect.controllerName != null)
                      ? Text(
                            connect.controllerName!,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.2, end: 0, duration: 500.ms)
                      : Text(
                        "未接続",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                  const SizedBox(width: 4),
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: switch (connect.state) {
                        ConnectState.ready => colorScheme.surface,
                        ConnectState.connected => Colors.green,
                        ConnectState.offline => colorScheme.error,
                      },
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      backgroundColor: colorScheme.surfaceContainer,
    );
  }
}
