// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_action_select_box.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class SelectWorkflowContainer extends HookConsumerWidget {
  const SelectWorkflowContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 380,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: DoubleLineBorderContainer(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          borderRadius: 32,
          borderType: DoubleLineBorderType.roundedRectangle,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'アクションを選択',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 16),
                WorkflowActionBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
