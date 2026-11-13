import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.label,
    required this.foregroundColor,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.surface,
    this.borderColor,
  });

  final String label;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(30));
    final bool isEnabled = onPressed != null;
    final Color effectiveForeground =
        isEnabled ? foregroundColor : AppColors.secondary;
    return Semantics(
      button: true,
      enabled: isEnabled,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            border: Border.all(
              color: isEnabled
                  ? (borderColor ?? AppColors.blueSoft)
                  : AppColors.surfaceSoft,
            ),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.shadowSoft,
                      offset: Offset(0, getProportionateScreenHeight(5)),
                      blurRadius: getProportionateScreenWidth(14),
                    ),
                  ]
                : const [],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onPressed,
            splashColor: foregroundColor.withValues(alpha: 0.1),
            highlightColor: foregroundColor.withValues(alpha: 0.05),
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
                      color: effectiveForeground,
                      size: getProportionateScreenWidth(22),
                    ),
                    SizedBox(width: getProportionateScreenWidth(8)),
                  ],
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        style: AppTypography.button
                            .copyWith(color: effectiveForeground),
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
