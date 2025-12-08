// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/main.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class DeviceSelectPage extends HookConsumerWidget {
  const DeviceSelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar().build(context, ref),
      body: Center(
        child: Column(
          children: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoute.editor.path);
              },
              child: Text("こんにちは"),
            ),
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
