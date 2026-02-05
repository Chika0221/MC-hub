// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:mc_hub/infrastructure/providers/workflow_edit_provider.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/select_workflow_container.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_board.dart';
import 'package:mc_hub/pages/setting_page/workflow_page/widgets/workflow_name_container.dart';
import 'package:mc_hub/widgets/custom_appbar.dart';

class WorkflowEditPage extends HookConsumerWidget {
  const WorkflowEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String workflowDisplayName = ref.watch(
      workflowEditProvider.select((value) => value.displayName),
    );

    return Scaffold(
      appBar: CustomAppbar(title: workflowDisplayName),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const Stack(
            children: [
              WorkflowBoard(),
              Positioned(left: 16, top: 16, child: WorkflowNameContainer()),
              Align(
                alignment: Alignment.centerRight,
                child: SelectWorkflowContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkflowBackground extends StatelessWidget {
  const WorkflowBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: DotPainter(
          dotColor: Theme.of(context).colorScheme.surface,
          spacing: 16,
          dotRadius: 1,
        ),
        size: Size.infinite,
        child: child,
      ),
    );
  }
}

class DotPainter extends CustomPainter {
  final Color dotColor;
  final double spacing;
  final double dotRadius;

  DotPainter({
    required this.dotColor,
    required this.spacing,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint =
        Paint()
          ..color = dotColor
          ..isAntiAlias = true;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // パラメータが変わらない限り再描画しない
  }
}
