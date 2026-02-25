// Package imports:

// Project imports:
import 'package:mc_hub/infrastructure/macro/run_macro.dart';
import 'package:mc_hub/infrastructure/notification/send_notification.dart';
import 'package:mc_hub/models/workflow.dart';

class WorkflowService {
  final Workflow workflow;

  WorkflowService({required this.workflow});

  Future<void> runWorkflow() async {
    WorkflowAction focusAction = workflow.actions.firstWhere(
      (action) => action.actionType == ActionType.Start,
    );

    final success = await runAction(focusAction);
    if (success) {
      print("Workflow '${workflow.displayName}' executed successfully.");
    } else {
      print("Workflow '${workflow.displayName}' execution failed.");
    }
  }

  WorkflowAction getActionById(String id) {
    return workflow.actions.firstWhere((action) => action.actionId == id);
  }

  Future<bool> runAction(WorkflowAction action) async {
    final List<bool> results = [];

    switch (action.actionType) {
      case ActionType.Macro:
        await MacroService.runMacro(action.macro);
        break;
      case ActionType.Delay:
        final delayDuration = action.delayDuration ?? Duration.zero;
        await Future.delayed(delayDuration);
        break;
      case ActionType.Notification:
        final message = action.message ?? "";
        sendNotification("ワークフロー実行中", message);
        break;
      case ActionType.Start:
        break;
      case ActionType.End:
        if (action.message != null && action.message!.isNotEmpty) {
          sendNotification("ワークフロー完了", action.message!);
        }
        return true;
    }

    for (String nextActionId in action.nextActionIds) {
      final bool result = await runAction(getActionById(nextActionId));
      results.add(result);
    }

    return results.every((result) => result == true);
  }
}
