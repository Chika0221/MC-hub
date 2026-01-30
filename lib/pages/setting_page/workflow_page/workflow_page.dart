// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/firebase_workflow_provider.dart';
import 'package:mc_hub/pages/setting_page/beam_setting_page.dart/widgets/beam_item_grid_view.dart';
import 'package:mc_hub/pages/setting_page/beam_setting_page.dart/widgets/code_container.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/workflow_edit_page.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class WorkflowPage extends HookConsumerWidget {
  const WorkflowPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: DoubleLineBorderContainer(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: IconButton.filled(
            onPressed:
                () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("ワークフローの新規作成"),
                      content: Text("ワークフローを新規作成しますか？"),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => WorkflowEditPage(),
                              ),
                            );
                          },
                          child: Text("作成"),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("キャンセル"),
                        ),
                      ],
                    );
                  },
                ),
            icon: Icon(Icons.add_rounded),
            iconSize: 48,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "ワークフロー一覧",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkflowSelectContainer extends HookConsumerWidget {
  const WorkflowSelectContainer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workflowsStream = ref.watch(firebaseWorkflowProvider);

    return workflowsStream.when(
      data: (workflows) {
        return Expanded(
          child: DoubleLineBorderContainer(
            borderType: DoubleLineBorderType.roundedRectangle,
            borderRadius: 48,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BeamItemGridView(
                childrenAspectRatio: 5,
                itemCount: workflows.length,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text("エラーが発生 $error"));
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
