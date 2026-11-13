import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class HomeHero extends StatelessWidget {
  const HomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '👑',
          style:
              TextStyle(fontSize: getProportionateScreenWidth(36), height: 1),
        ),
        SizedBox(height: getProportionateScreenHeight(4)),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'CHARADES',
            style: AppTypography.display.copyWith(
              color: AppColors.white,
              fontSize: getProportionateScreenWidth(44),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(4)),
        Text(
          'Act · Guess · Laugh',
          style: AppTypography.label.copyWith(color: AppColors.yellow),
        ),
      ],
    );
  }
}
