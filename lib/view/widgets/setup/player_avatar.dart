import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/utils/size_config.dart';

class PlayerAvatar extends StatelessWidget {
  const PlayerAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(52),
      height: getProportionateScreenWidth(52),
      padding: EdgeInsets.all(getProportionateScreenWidth(3)),
      decoration: const BoxDecoration(
        gradient: AppGradients.purpleTile,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(2)),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFB454), Color(0xFFFF8A5C)],
            ),
            shape: BoxShape.circle,
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
        ),
      ),
    );
  }
}
