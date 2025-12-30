// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/theme/custom_theme.dart';

class BeamSettingPage extends HookConsumerWidget {
  const BeamSettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Text(
            "--MAYUZAWA--",
            style: CustomTheme().titleTheme(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
