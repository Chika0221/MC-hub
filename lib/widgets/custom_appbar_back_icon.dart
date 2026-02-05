// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomBackIcon extends StatelessWidget {
  final Color color;
  const CustomBackIcon({super.key, required this.color});
  @override
  Widget build(BuildContext context) => _AlignedPaint(_BackPainter(color));
}

class _AlignedPaint extends StatelessWidget {
  const _AlignedPaint(this.painter);
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CustomPaint(size: const Size(10, 10), painter: painter),
    );
  }
}

class _BackPainter extends _IconPainter {
  _BackPainter(super.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      p,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width / 2, size.height),
      p,
    );
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width / 2, 0), p);
  }
}

abstract class _IconPainter extends CustomPainter {
  _IconPainter(this.color);
  final Color color;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
