import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/utils/size_config.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(48),
      height: getProportionateScreenWidth(48),
      decoration: BoxDecoration(
        gradient: AppGradients.purpleTile,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, getProportionateScreenHeight(5)),
            blurRadius: getProportionateScreenWidth(12),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '🎭',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(22),
            height: 1,
          ),
        ),
      ),
    );
  }
}
