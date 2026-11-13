import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/gradients.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'feature_card.dart';

class PartyRouletteCard extends StatelessWidget {
  const PartyRouletteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      emoji: '🎲',
      title: 'Party\nRoulette',
      subtitle: 'Let fate choose!',
      gradient: AppGradients.roulette,
      onTap: () {
        const List<WordCategory> packs = [
          WordCategory.animals,
          WordCategory.movies,
          WordCategory.actions,
          WordCategory.food,
        ];
        final WordCategory pick =
            packs[DateTime.now().millisecondsSinceEpoch % packs.length];
        context.read<GameViewModel>().startRoundWithCategory(pick);
      },
    );
  }
}
