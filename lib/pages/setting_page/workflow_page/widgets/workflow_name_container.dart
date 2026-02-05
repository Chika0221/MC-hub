// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/workflow_edit_provider.dart';
import 'package:mc_hub/widgets/double_line_border_container.dart';

class WorkflowNameContainer extends HookConsumerWidget {
  const WorkflowNameContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = ref.watch(
      workflowEditProvider.select((value) => value.displayName),
    );

    final textController = useTextEditingController(text: displayName);

    final textFieldWidth = useState<double>(300);

    useEffect(() {
      void listener() {
        ref
            .read(workflowEditProvider.notifier)
            .updateDisplayName(textController.text);
      }

      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, []);

    return DoubleLineBorderContainer(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed:
                  () =>
                      Navigator.of(context).pop(ref.read(workflowEditProvider)),
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.arrow_back),
            ),
            const VerticalDivider(
              width: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              color: Colors.white,
            ),
            SizedBox(
              width: textFieldWidth.value,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
