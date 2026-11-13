import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';

class QuestionMark extends StatelessWidget {
  const QuestionMark({
    super.key,
    required this.fontSize,
    this.color = AppColors.blue,
  });

  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '?',
      style: AppTypography.display.copyWith(
        color: color,
        fontSize: fontSize,
        height: 1,
      ),
    );
  }
}
