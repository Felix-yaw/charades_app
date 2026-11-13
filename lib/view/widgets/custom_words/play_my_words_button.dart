import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/gradient_button.dart';

class PlayMyWordsButton extends StatelessWidget {
  const PlayMyWordsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, bool>(
      selector: (context, gameViewModel) => gameViewModel.customWords.isNotEmpty,
      builder: (context, hasCustomWords, child) {
        if (!hasCustomWords) return const SizedBox.shrink();
        return GradientButton(
          label: 'Play My Words',
          icon: Icons.play_arrow_rounded,
          gradient: AppGradients.blueButton,
          foregroundColor: AppColors.white,
          onPressed: () => context
              .read<GameViewModel>()
              .startRoundWithCategory(WordCategory.custom),
        );
      },
    );
  }
}
