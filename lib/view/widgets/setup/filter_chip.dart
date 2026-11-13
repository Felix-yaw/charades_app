import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class FilterChipItem extends StatelessWidget {
  const FilterChipItem({
    super.key,
    required this.label,
    required this.emoji,
    required this.bubbleColor,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String emoji;
  final Color bubbleColor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(22));
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blueSoft : AppColors.surface,
            borderRadius: borderRadius,
            border: Border.all(
              color: isSelected ? AppColors.blue : AppColors.surfaceSoft,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowSoft,
                offset: Offset(0, getProportionateScreenHeight(3)),
                blurRadius: getProportionateScreenWidth(8),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10),
                vertical: getProportionateScreenHeight(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: getProportionateScreenWidth(26),
                    height: getProportionateScreenWidth(26),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(9)),
                    ),
                    child: Center(
                      child: Text(
                        emoji,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(13),
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(7)),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        style: AppTypography.label.copyWith(
                          color: AppColors.ink,
                          fontSize: getProportionateScreenWidth(13),
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
