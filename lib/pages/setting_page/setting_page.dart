// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/setting_page/beam_setting_page.dart/beam_setting_page.dart';
import 'package:mc_hub/pages/setting_page/remocon_page.dart/remocon_page.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/workflow_page.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyAnimatedIndexedStack(
      index: selectedIndex,
      animationBuilder:
          (context, animation, child) =>
              FadeTransition(opacity: animation, child: child),
      curve: Curves.easeInOutSine,
      duration: Duration(milliseconds: 240),
      children: [RemoconPage(), WorkflowPage(), BeamSettingPage()],
    );
  }
}
