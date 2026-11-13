import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'word_chip_list.dart';

class GuessedSection extends StatelessWidget {
  const GuessedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, List<WordCard>>(
      selector: (context, gameViewModel) => gameViewModel.guessedWords,
      builder: (context, wordCards, child) {
        return WordChipList(
          title: 'Guessed',
          wordCards: wordCards,
          emptyText: 'No words guessed this round.',
          accentColor: AppColors.greenSoft,
        );
      },
    );
  }
}
