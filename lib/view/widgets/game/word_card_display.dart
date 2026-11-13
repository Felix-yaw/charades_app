import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';

class WordCardDisplay extends StatelessWidget {
  const WordCardDisplay({super.key, required this.wordCard});

  final WordCard wordCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(36),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(32)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, getProportionateScreenHeight(12)),
            blurRadius: getProportionateScreenWidth(28),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            wordCard.category.label.toUpperCase(),
            style: AppTypography.label.copyWith(
              color: AppColors.blue,
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              wordCard.text,
              textAlign: TextAlign.center,
              style: AppTypography.display.copyWith(color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}
