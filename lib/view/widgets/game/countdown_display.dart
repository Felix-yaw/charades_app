import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class CountdownDisplay extends StatelessWidget {
  const CountdownDisplay({super.key, required this.countdownValue});

  final int countdownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Get ready!',
          style: AppTypography.heading.copyWith(color: AppColors.secondary),
        ),
        SizedBox(height: getProportionateScreenHeight(4)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            '$countdownValue',
            style: AppTypography.display.copyWith(
              color: AppColors.blue,
              fontSize: getProportionateScreenWidth(110),
            ),
          ),
        ),
      ],
    );
  }
}
