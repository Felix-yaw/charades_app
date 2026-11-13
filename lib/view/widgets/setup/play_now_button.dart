import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/gradient_button.dart';

class PlayNowButton extends StatelessWidget {
  const PlayNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: 'Play Now',
      icon: Icons.play_arrow_rounded,
      gradient: AppGradients.yellowButton,
      foregroundColor: AppColors.ink,
      onPressed: () =>
          context.read<GameViewModel>().startRoundWithCategory(WordCategory.all),
    );
  }
}
