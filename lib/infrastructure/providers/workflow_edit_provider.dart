// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';

class WorkflowEditNotifier extends Notifier<Workflow> {
  @override
  build() {
    return Workflow(
      displayName: "名前未設定のワークフロー",
      actions: [],
      trigger: WorkflowTrigger(
        type: TriggerType.EventBased,
        scheduledTime: null,
      ),
    );
  }

  WorkflowAction getActionById(String actionId) {
    return state.actions.firstWhere((action) => action.actionId == actionId);
  }

  void updateAction(WorkflowAction updatedAction) {
    final updatedActions =
        state.actions.map((action) {
          if (action.actionId == updatedAction.actionId) {
            return updatedAction;
          }
          return action;
        }).toList();

    state = state.copyWith(actions: updatedActions);
  }

  void deleteAction(String actionId) {
    final updatedActions =
        state.actions
            .map((targetAction) {
              if (targetAction.nextActionIds.contains(actionId)) {
                final newNextActionIds = List<String>.from(
                  targetAction.nextActionIds,
                )..remove(actionId);
                return targetAction.copyWith(nextActionIds: newNextActionIds);
              }

              return targetAction;
            })
            .where((action) => action.actionId != actionId)
            .toList();

    state = state.copyWith(actions: updatedActions);
  }

  void update(Workflow newWorkflow) {
    state = newWorkflow;
  }

  void updateDisplayName(String newName) {
    state = state.copyWith(displayName: newName);
  }

  void updateActions(List<WorkflowAction> newActions) {
    state = state.copyWith(actions: newActions);
  }

  void updateTrigger(WorkflowTrigger newTrigger) {
    state = state.copyWith(trigger: newTrigger);
  }
}

final WorkflowEditProvider =
    NotifierProvider.autoDispose<WorkflowEditNotifier, Workflow>(
      WorkflowEditNotifier.new,
    );
