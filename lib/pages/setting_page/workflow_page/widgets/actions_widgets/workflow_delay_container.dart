part of '../workflow_action_container.dart';

class WorkflowDelayContainer extends HookConsumerWidget {
  const WorkflowDelayContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final highlightColor = colorScheme.tertiary;
    final headerTextColor = colorScheme.onTertiary;

    final action = ref
        .watch(workflowEditProvider.notifier)
        .getActionById(actionId);

    final delaySeconds = action.delayDuration?.inSeconds ?? 0;

    return WorkflowActionContainer(
      backgroundColor: colorScheme.tertiary.withValues(alpha: 0.15),
      highlightColor: highlightColor,
      headerTextColor: headerTextColor,
      bodyTextColor: colorScheme.onSurface,
      child: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: TextFormField(
            initialValue: delaySeconds.toString(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: highlightColor),
              ),
              suffix: Text('s', style: TextStyle(color: colorScheme.onSurface)),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final seconds = int.tryParse(value) ?? 0;
              final updatedAction = action.copyWith(
                delayDuration: Duration(seconds: seconds),
              );
              ref
                  .read(workflowEditProvider.notifier)
                  .updateAction(updatedAction);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '値を入力してください';
              }
              try {
                int.parse(value);
              } catch (e) {
                return '有効な数値を入力してください';
              }
              return null;
            },
          ),
        ),
      ),
      action: action,
      icon: Icons.timer,
    );
  }
}
