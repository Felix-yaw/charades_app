import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'custom_word_row.dart';

class CustomWordList extends StatelessWidget {
  const CustomWordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, List<WordCard>>(
      selector: (context, gameViewModel) => gameViewModel.customWords,
      builder: (context, customWords, child) {
        if (customWords.isEmpty) {
          return Text(
            'No custom words yet. Add some to build your own pack.',
            style: AppTypography.body
                .copyWith(color: AppColors.secondary),
          );
        }
        return Column(
          children: [
            for (final WordCard wordCard in customWords) ...[
              CustomWordRow(word: wordCard.text),
              SizedBox(height: getProportionateScreenHeight(8)),
            ],
          ],
        );
      },
    );
  }
}
