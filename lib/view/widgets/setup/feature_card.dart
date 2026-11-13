import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(24));
    return Semantics(
      button: true,
      label: title,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                offset: Offset(0, getProportionateScreenHeight(8)),
                blurRadius: getProportionateScreenWidth(18),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            splashColor: Colors.white24,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
                vertical: getProportionateScreenHeight(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        emoji,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(22),
                          height: 1,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.white,
                        size: getProportionateScreenWidth(18),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(12)),
                  Text(
                    title,
                    style: AppTypography.title.copyWith(
                      color: AppColors.white,
                      fontSize: getProportionateScreenWidth(16),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(4)),
                  Text(
                    subtitle,
                    style: AppTypography.body.copyWith(
                      color: AppColors.white,
                      fontSize: getProportionateScreenWidth(11),
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
