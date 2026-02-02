// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_container.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_path.dart';
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
              if (data.data is WorkflowAction) {
                final offset = data.offset;
                final sceneOffset = transformationController.toScene(offset);

                final action = (data.data as WorkflowAction).copyWith(
                  positionX: sceneOffset.dx,
                  positionY: sceneOffset.dy,
                );

                final updateActions = [...actions.value];
                updateActions.removeWhere((e) => e.actionId == action.actionId);

                actions.value = [...updateActions, action];
              } else if (data.data is String) {
                final offset = data.offset;
                final sceneOffset = transformationController.toScene(offset);

                final getActionId = data.data as String;

                var fromAction = actions.value.firstWhere(
                  (element) => element.actionId == getActionId,
                );

                final offsetAllowedDeviation = 200.0;

                actions.value.forEach((targetAction) {
                  final difX = (sceneOffset.dx - targetAction.positionX).abs();
                  final difY = (sceneOffset.dy - targetAction.positionY).abs();

                  if (difX < offsetAllowedDeviation &&
                      difY < offsetAllowedDeviation) {
                    fromAction = fromAction.copyWith(
                      nextActionIds: [
                        ...fromAction.nextActionIds,
                        targetAction.actionId,
                      ],
                    );
                  }
                });

                final updateActions = [...actions.value];
                updateActions.removeWhere(
                  (e) => e.actionId == fromAction.actionId,
                );

                actions.value = [...updateActions, fromAction];
              }
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

                    final boxsize = 180;

                    return Positioned(
                      left: action.positionX + 180 + 8 + 8 + 2,
                      top: action.positionY + 60,
                      child: WorkflowPath(
                        startOffset: Offset(
                          action.positionX + 180 + 8 + 8 + 2,
                          action.positionY + 60,
                        ),
                        endOffset: Offset(1500, 1500),
                      ),
                    );
                  }),

                  ...List.generate(actions.value.length, (int index) {
                    final action = actions.value[index];

                    print(action);

                    return Positioned(
                      left: action.positionX,
                      top: action.positionY,
                      child: ActionContainer(action: action, actions: actions),
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
