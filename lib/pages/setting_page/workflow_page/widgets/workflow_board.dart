// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_container.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/workflow_edit_page.dart';

class WorkflowBoard extends HookConsumerWidget {
  const WorkflowBoard({super.key, required this.workflow});

  final ValueNotifier<Workflow> workflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = useState<List<WorkflowAction>>(workflow.value.actions);

    final transformationController = useTransformationController();

    final boardSize = 3000.0;

    return InteractiveViewer(
      transformationController: transformationController,
      minScale: 0.1,
      maxScale: 4.0,
      constrained: false,
      child: WorkflowBackground(
        child: SizedBox.square(
          dimension: boardSize,
          child: DragTarget(
            onAcceptWithDetails: (data) {
              final offset = data.offset;

              final sceneOffset = transformationController.toScene(offset);

              print(sceneOffset);

              final action = (data.data as WorkflowAction).copyWith(
                positionX: sceneOffset.dx,
                positionY: sceneOffset.dy,
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
        ),
      ),
    );
  }
}
