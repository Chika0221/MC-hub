part of '../workflow_action_container.dart';

class WorkflowStartContainer extends HookConsumerWidget {
  const WorkflowStartContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final action = ref
        .watch(workflowEditProvider.notifier)
        .getActionById(actionId);

    final trigger = ref.watch(
      workflowEditProvider.select((workflow) => workflow.trigger),
    );

    final isTimeTrigger = (trigger.type == TriggerType.TimeBased);

    final TimeOfDay scheduledTime =
        trigger.scheduledTime != null
            ? TimeOfDay.fromDateTime(trigger.scheduledTime!)
            : TimeOfDay.now();

    return WorkflowActionContainer(
      backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
      highlightColor: colorScheme.primary,
      headerTextColor: colorScheme.onPrimary,
      bodyTextColor: colorScheme.onSurface,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("時間トリガー"),
              Switch(
                value: isTimeTrigger,
                onChanged: (value) {
                  ref
                      .read(workflowEditProvider.notifier)
                      .updateTrigger(
                        trigger.copyWith(
                          type:
                              value
                                  ? TriggerType.TimeBased
                                  : TriggerType.EventBased,
                        ),
                      );
                },
              ),
            ],
          ),
          if (isTimeTrigger) ...[
            const SizedBox(height: 2),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: scheduledTime,
                  );
                  if (newTime != null) {
                    final now = DateTime.now();
                    final scheduledDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      newTime.hour,
                      newTime.minute,
                    );
                    ref
                        .read(workflowEditProvider.notifier)
                        .updateTrigger(
                          trigger.copyWith(scheduledTime: scheduledDateTime),
                        );
                  }
                },
                icon: const Icon(Icons.schedule_rounded),
                label: Text("${scheduledTime.format(context)}"),
              ),
            ),
          ],
        ],
      ),
      action: action,
      icon: Icons.play_arrow,
      isShowStartAnker: false,
    );
  }
}
