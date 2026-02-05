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
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;
    final path = Path();

    const double arrowSize = 8.0;

    if (delta.dx < 0) {
      const double outlierValue = 48.0;

      path
        ..lineTo(outlierValue, 0)
        ..lineTo(outlierValue, delta.dy / 2)
        ..lineTo(delta.dx - (outlierValue * 2.0), delta.dy / 2)
        ..lineTo(delta.dx - (outlierValue * 2.0), delta.dy)
        ..lineTo(delta.dx, delta.dy);
    } else {
      path
        ..lineTo(delta.dx / 2, 0)
        ..lineTo(delta.dx / 2, delta.dy)
        ..lineTo(delta.dx, delta.dy);
    }
    // 矢印
    path
      ..moveTo(delta.dx - arrowSize, delta.dy - arrowSize)
      ..lineTo(delta.dx, delta.dy)
      ..lineTo(delta.dx - arrowSize, delta.dy + arrowSize);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
