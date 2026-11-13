import 'package:flutter/material.dart';

import 'star_burst_painter.dart';

class StarBurst extends StatelessWidget {
  const StarBurst({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: StarBurstPainter(color: color));
  }
}
