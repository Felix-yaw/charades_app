import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.color = AppColors.ink});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.heading.copyWith(color: color),
    );
  }
}
