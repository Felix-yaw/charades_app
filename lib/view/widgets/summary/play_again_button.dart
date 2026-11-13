import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/gradients.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/gradient_button.dart';

class PlayAgainButton extends StatelessWidget {
  const PlayAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      label: 'Play again',
      icon: Icons.replay_rounded,
      gradient: AppGradients.blueButton,
      onPressed: () => context.read<GameViewModel>().playAgain(),
    );
  }
}
