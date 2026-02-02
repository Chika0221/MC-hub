// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_container.dart';

class WorkflowActionBox extends HookConsumerWidget {
  const WorkflowActionBox({super.key, required this.action});

  final WorkflowAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draggableAction = useState(action);

    final uuid = useMemoized(() => const Uuid());

    return Listener(
      onPointerHover: (event) {
        //TODO なんかうまいことUUID更新されないときがある
        draggableAction.value = draggableAction.value.copyWith(
          actionId: uuid.v4(),
        );
      },
      child: Draggable<WorkflowAction>(
        child: Container(
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Center(
            child: Text(
              action.actionName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        feedback: Material(
          color: Colors.transparent,
          child: ActionContainer(
            action: draggableAction.value,
            actions: ValueNotifier([]),
          ),
        ),
        data: draggableAction.value,
      ),
    );
  }
}
