import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mc_hub/main.dart';
import 'package:mc_hub/pages/deviceSelect_page/widgets/backgroundGradiantContainer.dart';

class DeviceSelectPage extends HookConsumerWidget {
  const DeviceSelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Backgroundgradiantcontainer(
        child: Center(
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
      ),
    );
  }
}
