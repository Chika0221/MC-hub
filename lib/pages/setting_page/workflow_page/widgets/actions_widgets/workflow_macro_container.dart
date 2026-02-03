part of '../workflow_action_container.dart';

class WorkflowMacroContainer extends HookConsumerWidget {
  const WorkflowMacroContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPreview = actionId == "";

    final action = ref
        .watch(WorkflowEditProvider.notifier)
        .getActionById(actionId);

    return WorkflowActionContainer(
      backgroundColor: colorScheme.secondary.withValues(alpha: 0.15),
      highlightColor: colorScheme.secondary,
      headerTextColor: colorScheme.onSecondary,
      bodyTextColor: colorScheme.onSurface,
      child: const Center(child: Text("Macro Action")),
      action: action,
      icon: Icons.code,
    );
  }
}
