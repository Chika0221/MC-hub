part of '../workflow_action_container.dart';

class WorkflowMacroContainer extends HookConsumerWidget {
  const WorkflowMacroContainer({super.key, required this.actionId});

  final String actionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final highlightColor = colorScheme.secondary;
    final headerTextColor = colorScheme.onSecondary;

    final action = ref
        .watch(workflowEditProvider.notifier)
        .getActionById(actionId);

    final macro = action.macro;

    return WorkflowActionContainer(
      backgroundColor: colorScheme.secondary.withValues(alpha: 0.15),
      highlightColor: highlightColor,
      headerTextColor: headerTextColor,
      bodyTextColor: colorScheme.onSurface,
      action: action,
      icon: Icons.code,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              macro?.name ?? "マクロ未設定",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: highlightColor,
                  foregroundColor: headerTextColor,
                ),
                onPressed: () async {
                  final Macro? macro = await showDialog(
                    context: context,
                    builder: (context) => const MacroSettingDialog(title: "マクロを選択"),
                  );
                  if (macro != null) {
                    final updatedAction = action.copyWith(
                      actionName: "${macro.type.displayLabel}マクロ",
                      macro: macro,
                    );
                    ref
                        .read(workflowEditProvider.notifier)
                        .updateAction(updatedAction);
                  }
                },
                label: const Text("マクロを編集"),
                icon: Icon(macro?.type.displayIcon ?? Icons.code_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
