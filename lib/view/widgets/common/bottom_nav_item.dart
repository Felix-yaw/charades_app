import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String tooltip;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? AppColors.yellow : AppColors.secondary;
    return Semantics(
      button: true,
      selected: isSelected,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(getProportionateScreenWidth(18)),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14),
              vertical: getProportionateScreenHeight(6),
            ),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0x29FFC83D) : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(18)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: getProportionateScreenWidth(24),
                  color: color,
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: AppTypography.body.copyWith(
                      color: color,
                      fontSize: getProportionateScreenWidth(11),
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
