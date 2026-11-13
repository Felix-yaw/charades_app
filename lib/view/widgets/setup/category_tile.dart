import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../common/star_burst.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.label,
    required this.emoji,
    required this.bubbleColor,
    required this.starburstColor,
    required this.onTap,
  });

  final String label;
  final String emoji;
  final Color bubbleColor;
  final Color starburstColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(26));
    return Semantics(
      button: true,
      label: label,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                offset: Offset(0, getProportionateScreenHeight(8)),
                blurRadius: getProportionateScreenWidth(20),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            splashColor: AppColors.blueSoft,
            highlightColor: AppColors.surfaceSoft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(12),
                vertical: getProportionateScreenHeight(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    height: getProportionateScreenWidth(78),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(20)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: StarBurst(color: starburstColor),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            emoji,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(42),
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      style: AppTypography.label.copyWith(
                        color: AppColors.ink,
                        fontSize: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
