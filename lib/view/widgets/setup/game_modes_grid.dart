import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/gradients.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'mode_tile.dart';

class GameModesGrid extends StatelessWidget {
  const GameModesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, bool>(
      selector: (context, gameViewModel) =>
          gameViewModel.customWords.isNotEmpty,
      builder: (context, hasCustomWords, child) {
        final GameViewModel gameViewModel = context.read<GameViewModel>();
        return Wrap(
          spacing: getProportionateScreenWidth(12),
          runSpacing: getProportionateScreenHeight(12),
          children: [
            _tile(
              context,
              width: 142,
              emoji: '🎭',
              label: 'Classic',
              gradient: AppGradients.blueButton,
              onTap: () {
                gameViewModel
                  ..setReverseGestures(false)
                  ..selectRoundSeconds(60)
                  ..startRoundWithCategory(WordCategory.all);
              },
            ),
            _tile(
              context,
              width: 142,
              emoji: '⚡',
              label: 'Speed Round',
              gradient: AppGradients.roulette,
              onTap: () {
                gameViewModel
                  ..setReverseGestures(false)
                  ..selectRoundSeconds(30)
                  ..startRoundWithCategory(WordCategory.all);
              },
            ),
            _tile(
              context,
              width: 142,
              emoji: '🔁',
              label: 'Reverse',
              gradient: AppGradients.reverseMode,
              onTap: () {
                gameViewModel
                  ..setReverseGestures(true)
                  ..selectRoundSeconds(60)
                  ..startRoundWithCategory(WordCategory.all);
              },
            ),
            if (hasCustomWords)
              _tile(
                context,
                width: 142,
                emoji: '✍️',
                label: 'My Words',
                gradient: AppGradients.greenTile,
                onTap: () {
                  gameViewModel
                    ..setReverseGestures(false)
                    ..selectRoundSeconds(60)
                    ..startRoundWithCategory(WordCategory.custom);
                },
              ),
          ],
        );
      },
    );
  }

  Widget _tile(
    BuildContext context, {
    required double width,
    required String emoji,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: getProportionateScreenWidth(width),
      child: ModeTile(
        emoji: emoji,
        label: label,
        gradient: gradient,
        onTap: onTap,
      ),
    );
  }
}
