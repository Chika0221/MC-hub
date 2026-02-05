part of '../workflow_action_container.dart';

class WorkflowEndContainer extends HookConsumerWidget {
  const WorkflowEndContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final action = ref
        .watch(workflowEditProvider.notifier)
        .getActionById(actionId);

    final endMessage = action.message ?? '';
    final isEndNotificationEnabled = endMessage.isNotEmpty;

    return WorkflowActionContainer(
      backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
      highlightColor: colorScheme.primary,
      headerTextColor: colorScheme.onPrimary,
      bodyTextColor: colorScheme.onSurface,
      action: action,
      icon: Icons.stop,
      isShowEndAnker: false,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("終了通知"),
            Switch(
              value: isEndNotificationEnabled,
              onChanged: (value) {
                if (value) {
                  final updatedAction = action.copyWith(
                    message: "ワークフローが終了しました。",
                  );
                  ref
                      .read(workflowEditProvider.notifier)
                      .updateAction(updatedAction);
                } else {
                  final updatedAction = action.copyWith(message: '');
                  ref
                      .read(workflowEditProvider.notifier)
                      .updateAction(updatedAction);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
