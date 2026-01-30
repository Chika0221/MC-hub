// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/models/workflow.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class WorkflowNameContainer extends HookConsumerWidget {
  const WorkflowNameContainer({super.key, required this.workflow});

  final ValueNotifier<Workflow> workflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(
      text: workflow.value.displayName,
    );

    final textFieldWidth = useState<double>(300);

    useEffect(() {
      void listener() {
        workflow.value = workflow.value.copyWith(
          displayName: textController.text,
        );
      }

      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, []);

    return DoubleLineBorderContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.arrow_back),
            ),
            const VerticalDivider(
              width: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Colors.white,
            ),
            Container(
              width: textFieldWidth.value,
              child: TextField(
                controller: textController,
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    );
  }
}
