import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class DurationOption extends StatelessWidget {
  const DurationOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(18));
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            gradient: isSelected ? AppGradients.blueButton : null,
            color: isSelected ? null : AppColors.surfaceSoft,
            borderRadius: borderRadius,
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(13),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: AppTypography.title.copyWith(
                      color: isSelected ? AppColors.white : AppColors.ink,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
