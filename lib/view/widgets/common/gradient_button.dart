import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.gradient,
    required this.onPressed,
    this.icon,
    this.foregroundColor = AppColors.white,
  });

  final String label;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(30));
    final bool isEnabled = onPressed != null;
    return Semantics(
      button: true,
      enabled: isEnabled,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            gradient: isEnabled ? gradient : null,
            color: isEnabled ? null : AppColors.surfaceSoft,
            borderRadius: borderRadius,
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.shadow,
                      offset: Offset(0, getProportionateScreenHeight(8)),
                      blurRadius: getProportionateScreenWidth(18),
                    ),
                  ]
                : const [],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onPressed,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: isEnabled
                          ? foregroundColor
                          : AppColors.secondary,
                      size: getProportionateScreenWidth(22),
                    ),
                    SizedBox(width: getProportionateScreenWidth(8)),
                  ],
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        style: AppTypography.button.copyWith(
                          color: isEnabled
                              ? foregroundColor
                              : AppColors.secondary,
                        ),
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
