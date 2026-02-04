// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/workflow_edit_provider.dart';
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_container.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_path.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/workflow_edit_page.dart';

class WorkflowBoard extends HookConsumerWidget {
const WorkflowBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(
      WorkflowEditProvider.select((value) => value.actions),
    );

    final transformationController = useTransformationController();

    final boardSize = 3000.0;

    List<Widget> createWorkflowPaths(List<WorkflowAction> actions) {
      const startBoxOffset = Offset(180 + 8 + 8 + 2, 60);
      const endBoxOffset = Offset(4, 60);

      final List<Widget> paths = [];

      for (final action in actions) {
        for (final nextActionId in action.nextActionIds) {
          final nextAction = actions.firstWhere(
            (element) => element.actionId == nextActionId,
          );

          paths.add(
            Positioned(
              left: action.positionX + startBoxOffset.dx,
              top: action.positionY + startBoxOffset.dy,
              child: WorkflowPath(
                startOffset: Offset(
                  action.positionX + startBoxOffset.dx,
                  action.positionY + startBoxOffset.dy,
                ),
                endOffset: Offset(
                  nextAction.positionX + endBoxOffset.dx,
                  nextAction.positionY + endBoxOffset.dy,
                ),
              ),
            ),
          );
        }
      }

      return paths;
    }

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

                final updateActions = [...actions];
                updateActions.removeWhere((e) => e.actionId == action.actionId);

                ref.read(WorkflowEditProvider.notifier).updateActions([
                  ...updateActions,
                  action,
                ]);
              } else if (data.data is String) {
                final offset = data.offset;
                final sceneOffset = transformationController.toScene(offset);

                final getActionId = data.data as String;

                var fromAction = actions.firstWhere(
                  (element) => element.actionId == getActionId,
                );

                final double offsetAllowedDeviation = 40.0;

                WorkflowAction? nearestAction;
                var minDistanceSquared = double.infinity;

                for (final targetAction in actions) {
                  if (targetAction.actionId == fromAction.actionId) continue;
                  if (fromAction.nextActionIds.contains(targetAction.actionId))
                    continue;

                  final dx = sceneOffset.dx - (targetAction.positionX + 4.0);
                  final dy = sceneOffset.dy - (targetAction.positionY + 60.0);
                  final distanceSquared = (dx * dx) + (dy * dy);

                  if (distanceSquared < minDistanceSquared) {
                    minDistanceSquared = distanceSquared;
                    nearestAction = targetAction;
                  }
                }

                if (nearestAction != null) {
                  final difX =
                      (sceneOffset.dx - (nearestAction.positionX + 4.0)).abs();
                  final difY =
                      (sceneOffset.dy - (nearestAction.positionY + 60.0)).abs();

                  if (difX < offsetAllowedDeviation &&
                      difY < offsetAllowedDeviation) {
                    fromAction = fromAction.copyWith(
                      nextActionIds: [
                        ...fromAction.nextActionIds,
                        nearestAction.actionId,
                      ],
                    );
                  }
                }

                final updateActions = [...actions];
                updateActions.removeWhere(
                  (e) => e.actionId == fromAction.actionId,
                );

                ref.read(WorkflowEditProvider.notifier).updateActions([
                  ...updateActions,
                  fromAction,
                ]);
              }
            },
            builder: (
              BuildContext context,
              List<Object?> candidateData,
              List<dynamic> rejectedData,
            ) {
              return Stack(
                children: [
                  ...createWorkflowPaths(actions),
                  ...actions.map(
                    (action) => Positioned(
                      left: action.positionX,
                      top: action.positionY,
                      child: ActionContainer(
                        key: ValueKey(action.actionId),
                        actionId: action.actionId,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
