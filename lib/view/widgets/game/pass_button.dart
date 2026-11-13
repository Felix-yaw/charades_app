import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/soft_button.dart';

class PassButton extends StatelessWidget {
  const PassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, bool>(
      selector: (context, gameViewModel) => gameViewModel.isRoundActive,
      builder: (context, isRoundActive, child) {
        return SoftButton(
          label: 'Pass',
          icon: Icons.close_rounded,
          foregroundColor: AppColors.ink,
          backgroundColor: AppColors.surface,
          onPressed:
              isRoundActive ? () => context.read<GameViewModel>().pass() : null,
        );
      },
    );
  }
}
