part of '../workflow_action_container.dart';

class WorkflowNotificationContainer extends HookConsumerWidget {
  const WorkflowNotificationContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPreview = actionId == "";

    final action = ref
        .watch(WorkflowEditProvider.notifier)
        .getActionById(actionId);

    return WorkflowActionContainer(
      backgroundColor: colorScheme.tertiary.withValues(alpha: 0.15),
      highlightColor: colorScheme.tertiary,
      headerTextColor: colorScheme.onTertiary,
      bodyTextColor: colorScheme.onSurface,
      child: const Center(child: Text("Notification Action")),
      action: action,
      icon: Icons.notifications,
    );
  }
}
