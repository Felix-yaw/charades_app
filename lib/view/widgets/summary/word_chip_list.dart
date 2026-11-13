import 'package:flutter/material.dart';

import '../../../core/constants/animation.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../common/section_title.dart';

class WordChipList extends StatelessWidget {
  const WordChipList({
    super.key,
    required this.title,
    required this.wordCards,
    required this.emptyText,
    required this.accentColor,
  });

  final String title;
  final List<WordCard> wordCards;
  final String emptyText;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: AppDurations.slow,
      curve: AppCurves.easeOut,
      builder: (context, reveal, child) {
        return Opacity(
          opacity: reveal.clamp(0, 1),
          child: Transform.translate(
            offset: Offset(0, getProportionateScreenHeight(12) * (1 - reveal)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('$title (${wordCards.length})'),
          SizedBox(height: getProportionateScreenHeight(12)),
          if (wordCards.isEmpty)
            Text(
              emptyText,
              style:
                  AppTypography.body.copyWith(color: AppColors.secondary),
            )
          else
            Wrap(
              spacing: getProportionateScreenWidth(8),
              runSpacing: getProportionateScreenHeight(8),
              children: [
                for (final WordCard wordCard in wordCards)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(14),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(16)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowSoft,
                          offset: Offset(0, getProportionateScreenHeight(4)),
                          blurRadius: getProportionateScreenWidth(10),
                        ),
                      ],
                    ),
                    child: Text(
                      wordCard.text,
                      style: AppTypography.label.copyWith(
                        color: AppColors.ink,
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
