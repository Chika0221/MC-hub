// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class WorkflowEditPage extends HookConsumerWidget {
  const WorkflowEditPage({super.key, this.openWorkflow = null});

  final Workflow? openWorkflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<Workflow> workflow = useState(
      openWorkflow ??
          Workflow(
            displayName: "名前未設定のワークフロー",
            actions: [],
            trigger: WorkflowTrigger(
              type: TriggerType.EventBased,
              scheduledTime: null,
            ),
          ),
    );

    return Scaffold(
      appBar: CustomAppbar(title: workflow.value.displayName),
      body: Center(child: Text("Workflow Edit Page")),
    );
  }
}
