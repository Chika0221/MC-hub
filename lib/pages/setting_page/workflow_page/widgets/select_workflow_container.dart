// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_select_box.dart';

class SelectWorkflowContainer extends HookConsumerWidget {
  const SelectWorkflowContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(width: 380, child: Center(child: WorkflowActionBox()));
  }
}
