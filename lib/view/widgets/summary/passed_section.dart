import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'word_chip_list.dart';

class PassedSection extends StatelessWidget {
  const PassedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, List<WordCard>>(
      selector: (context, gameViewModel) => gameViewModel.passedWords,
      builder: (context, wordCards, child) {
        return WordChipList(
          title: 'Passed',
          wordCards: wordCards,
          emptyText: 'No passes this round.',
          accentColor: AppColors.purpleSoft,
        );
      },
    );
  }
}
