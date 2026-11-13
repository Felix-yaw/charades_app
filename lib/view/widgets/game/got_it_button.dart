import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/gradient_button.dart';

class GotItButton extends StatelessWidget {
  const GotItButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, bool>(
      selector: (context, gameViewModel) => gameViewModel.isRoundActive,
      builder: (context, isRoundActive, child) {
        return GradientButton(
          label: 'Got it',
          icon: Icons.check_rounded,
          gradient: AppGradients.yellowButton,
          foregroundColor: AppColors.ink,
          onPressed: isRoundActive
              ? () => context.read<GameViewModel>().markGuessed()
              : null,
        );
      },
    );
  }
}
