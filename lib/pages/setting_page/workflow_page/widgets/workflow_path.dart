// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WorkflowPath extends HookConsumerWidget {
  const WorkflowPath({
    super.key,
    required this.startOffset,
    required this.endOffset,
  });

  final Offset startOffset;
  final Offset endOffset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deltaOffset = endOffset - startOffset;

    return CustomPaint(
      painter: MyCustomPainter(context: context, delta: deltaOffset),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  const MyCustomPainter({
    super.repaint,
    required this.context,
    required this.delta,
  });

  final BuildContext context;
  final Offset delta;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Theme.of(context).colorScheme.onSurface
          ..strokeWidth = 2.0;

    if (delta.dx < 0) {
      const double outlierValue = 48.0;

      canvas.drawLine(Offset(0, 0), Offset(outlierValue, 0), paint);
      canvas.drawLine(
        Offset(outlierValue, 0),
        Offset(outlierValue, delta.dy / 2),
        paint,
      );
      canvas.drawLine(
        Offset(outlierValue, delta.dy / 2),
        Offset(delta.dx - (outlierValue * 2.0), delta.dy / 2),
        paint,
      );
      canvas.drawLine(
        Offset(delta.dx - (outlierValue * 2.0), delta.dy / 2),
        Offset(delta.dx - (outlierValue * 2.0), delta.dy),
        paint,
      );
      canvas.drawLine(
        Offset(delta.dx - (outlierValue * 2.0), delta.dy),
        Offset(delta.dx - (outlierValue * 1.0), delta.dy),
        paint,
      );
    } else {
      canvas.drawLine(Offset(0, 0), Offset(delta.dx / 2, 0), paint);
      canvas.drawLine(
        Offset(delta.dx / 2, 0),
        Offset(delta.dx / 2, delta.dy),
        paint,
      );
      canvas.drawLine(
        Offset(delta.dx / 2, delta.dy),
        Offset(delta.dx, delta.dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
