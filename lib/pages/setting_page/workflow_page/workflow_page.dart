// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/widgets/custom_appbar.dart';

class WorkflowPage extends HookConsumerWidget {
  const WorkflowPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Center(child: Text("Workflow Page")),
    );
  }
}
