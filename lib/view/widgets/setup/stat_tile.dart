import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../common/star_burst.dart';

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.emoji,
    required this.label,
    required this.value,
    required this.gradient,
    required this.starburstColor,
    required this.valueColor,
  });

  final String emoji;
  final String label;
  final String value;
  final Gradient gradient;
  final Color starburstColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.circular(getProportionateScreenWidth(26)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, getProportionateScreenHeight(8)),
            blurRadius: getProportionateScreenWidth(20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: getProportionateScreenWidth(110),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(getProportionateScreenWidth(26)),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Positioned.fill(
                  child: StarBurst(color: Color(0x2EFFFFFF)),
                ),
                Text(
                  emoji,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(44),
                    height: 1,
                  ),
                ),
                Positioned(
                  bottom: getProportionateScreenHeight(8),
                  child: Text(
                    label,
                    style: AppTypography.label.copyWith(
                      color: AppColors.white,
                      fontSize: getProportionateScreenWidth(13),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(14),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: AppTypography.display.copyWith(
                  color: valueColor,
                  fontSize: getProportionateScreenWidth(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
