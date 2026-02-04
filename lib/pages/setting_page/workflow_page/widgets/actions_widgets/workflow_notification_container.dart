part of '../workflow_action_container.dart';

class WorkflowNotificationContainer extends HookConsumerWidget {
  const WorkflowNotificationContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final highlightColor = colorScheme.tertiary;
    final headerTextColor = colorScheme.onTertiary;

    final action = ref
        .watch(WorkflowEditProvider.notifier)
        .getActionById(actionId);

    final notificationMessage = action.message ?? '';

    return WorkflowActionContainer(
      backgroundColor: colorScheme.tertiary.withValues(alpha: 0.15),
      highlightColor: highlightColor,
      headerTextColor: headerTextColor,
      bodyTextColor: colorScheme.onSurface,
      child: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: TextFormField(
            initialValue: notificationMessage,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: highlightColor),
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            onChanged: (value) {
              final updatedAction = action.copyWith(message: value);
              ref
                  .read(WorkflowEditProvider.notifier)
                  .updateAction(updatedAction);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'メッセージを入力してください';
              }
              return null;
            },
          ),
        ),
      ),
      action: action,
      icon: Icons.notifications,
    );
  }
}
