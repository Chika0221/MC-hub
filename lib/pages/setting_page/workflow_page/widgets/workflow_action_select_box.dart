// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';

class WorkflowActionBox extends HookConsumerWidget {
  const WorkflowActionBox({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = Container(width: 200, height: 100, color: Colors.blue);

    final flow = WorkflowAction(
      actionId: "0",
      nextActionIds: ["1"],
      actionName: 'test',
      positionX: 0,
      positionY: 0,
      actionType: ActionType.Start,
      macro: null,
      delayDuration: null,
      notificationMessage: null,
    );

    return Draggable(child: data, feedback: data, data: flow);
  }
}
