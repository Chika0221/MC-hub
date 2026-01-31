// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_container.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_name_container.dart';

class MainWorkflowContainer extends HookConsumerWidget {
  const MainWorkflowContainer({super.key, required this.workflow});

  final ValueNotifier<Workflow> workflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = useState<List<WorkflowAction>>(workflow.value.actions);

    return Expanded(
      child: DragTarget(
        onAcceptWithDetails: (data) {
          final offset = data.offset;

          final action = (data.data as WorkflowAction).copyWith(
            positionX: offset.dx,
            positionY: offset.dy,
          );

          final updateActions = [...actions.value];

          updateActions.removeWhere((e) => e.actionId == action.actionId);

          actions.value = [...updateActions, action];
        },
        builder: (
          BuildContext context,
          List<Object?> candidateData,
          List<dynamic> rejectedData,
        ) {
          return Stack(
            children: [
              Positioned(
                left: 16,
                top: 16,
                child: WorkflowNameContainer(workflow: workflow),
              ),
              ...List.generate(actions.value.length, (int index) {
                final action = actions.value[index];

                return Positioned(
                  left: action.positionX,
                  top: action.positionY,
                  child: ActionContainer(action: action),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
