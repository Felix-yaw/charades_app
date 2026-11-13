import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/round_record.dart';
import '../../../models/word_card.dart';

String formatRecordTime(DateTime playedAt) {
  final String minutes = playedAt.minute.toString().padLeft(2, '0');
  return '${playedAt.hour}:$minutes';
}

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.record});

  final RoundRecord record;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius:
            BorderRadius.circular(getProportionateScreenWidth(18)),
        border: Border.all(color: AppColors.blueSoft),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.category.label,
                  style: AppTypography.title
                      .copyWith(color: AppColors.white),
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                Text(
                  '${record.guessedCount} guessed · ${record.passedCount} passed · ${formatRecordTime(record.playedAt)}',
                  style: AppTypography.body.copyWith(
                    color: AppColors.secondary,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14),
              vertical: getProportionateScreenHeight(6),
            ),
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(14)),
            ),
            child: Text(
              'Score: ${record.score}',
              style: AppTypography.label.copyWith(
                color: AppColors.ink,
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
