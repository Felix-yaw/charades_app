import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/soft_button.dart';

class ChangeSettingsButton extends StatelessWidget {
  const ChangeSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SoftButton(
      label: 'Change settings',
      icon: Icons.tune_rounded,
      foregroundColor: AppColors.ink,
      onPressed: () => context.read<GameViewModel>().backToSetup(),
    );
  }
}
