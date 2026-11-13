import 'dart:math' as math;

import 'package:flutter/material.dart';

class StarBurstPainter extends CustomPainter {
  StarBurstPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double outer = size.shortestSide * 0.62;
    final double inner = outer * 0.58;
    final Paint paint = Paint()..color = color;

    final Path path = Path();
    const int points = 12;
    for (int point = 0; point < points * 2; point++) {
      final double angle = -math.pi / 2 + point * math.pi / points;
      final double radius = point.isEven ? outer : inner;
      final Offset vertex =
          center + Offset(math.cos(angle), math.sin(angle)) * radius;
      if (point == 0) {
        path.moveTo(vertex.dx, vertex.dy);
      } else {
        path.lineTo(vertex.dx, vertex.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant StarBurstPainter oldDelegate) =>
      oldDelegate.color != color;
}
