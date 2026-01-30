// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_name_container.dart';

class MainWorkflowContainer extends HookConsumerWidget {
  const MainWorkflowContainer({super.key, required this.workflow});

  final ValueNotifier<Workflow> workflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 16,
            child: WorkflowNameContainer(workflow: workflow),
          ),
        ],
      ),
    );
  }
}
