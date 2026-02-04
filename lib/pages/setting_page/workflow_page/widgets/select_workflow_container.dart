// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_select_box.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class SelectWorkflowContainer extends HookConsumerWidget {
  const SelectWorkflowContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClose = useState(false);

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
      width: (isClose.value) ? 120 : 380,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: DoubleLineBorderContainer(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          borderRadius: 32,
          borderType: DoubleLineBorderType.roundedRectangle,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (isClose.value) ? "選択" : "アクションを選択",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          ActionType.values.map((actionType) {
                            final action = WorkflowAction(
                              actionId: "",
                              nextActionIds: [],
                              actionName: actionType.displayName,
                              positionX: 0,
                              positionY: 0,
                              actionType: actionType,
                              macro: null,
                              delayDuration: null,
                              message: null,
                            );

                            return WorkflowActionBox(action: action);
                          }).toList(),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    isClose.value = !isClose.value;
                  },
                  icon: Icon(
                    (isClose.value)
                        ? Icons.open_in_full_rounded
                        : Icons.close_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
