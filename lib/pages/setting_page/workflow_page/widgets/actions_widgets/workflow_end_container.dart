part of '../workflow_action_container.dart';

class WorkflowEndContainer extends HookConsumerWidget {
  const WorkflowEndContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPreview = actionId == "";

    final action = ref
        .watch(WorkflowEditProvider.notifier)
        .getActionById(actionId);

    return WorkflowActionContainer(
      backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
      highlightColor: colorScheme.primary,
      headerTextColor: colorScheme.onPrimary,
      bodyTextColor: colorScheme.onSurface,
      child: const Center(child: Text("End Action")),
      action: action,
      icon: Icons.stop,
      isShowEndAnker: false,
    );
  }
}
