// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_workflow_provider.dart';
import 'package:mc_hub/infrastructure/providers/workflow_edit_provider.dart';
import 'package:mc_hub/infrastructure/workflow/run_workflow.dart';
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/workflow_edit_page.dart';

class WorkflowContainer extends HookConsumerWidget {
  const WorkflowContainer({super.key, required this.workflow});

  final Workflow workflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTimeBasedTrigger = workflow.trigger.type == TriggerType.TimeBased;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color:
            (workflow.state)
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
      ),
      padding: EdgeInsets.fromLTRB(24, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                ref
                    .watch(workflowEditInitialWorkflowProvider.notifier)
                    .updateInitialWorkflow(workflow);

                final Workflow? returnWorkflow = await Navigator.of(
                  context,
                ).push(
                  MaterialPageRoute(builder: (context) => WorkflowEditPage()),
                );

                if (returnWorkflow != null) {
                  ref
                      .read(firebaseWorkflowProvider.notifier)
                      .updateWorkflow(returnWorkflow);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    workflow.displayName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color:
                          (workflow.state)
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    "${workflow.trigger.type.name} トリガー | アクション数: ${workflow.actions.length}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          (workflow.state)
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isTimeBasedTrigger) ...[
            SizedBox(width: 16),
            IconButton.filled(
              icon: Icon(Icons.play_arrow_rounded),
              onPressed: () {
                WorkflowService(workflow: workflow).runWorkflow();
              },
            ),
          ],
        ],
      ),
    );
  }
}
