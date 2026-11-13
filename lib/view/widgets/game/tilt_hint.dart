import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

class TiltHint extends StatelessWidget {
  const TiltHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, (bool, bool)>(
      selector: (context, gameViewModel) => (
        gameViewModel.motionControlsEnabled,
        gameViewModel.reverseGestures,
      ),
      builder: (context, motionState, child) {
        final (bool motionControlsEnabled, bool reversed) = motionState;
        if (!motionControlsEnabled) return const SizedBox.shrink();
        final String hint = reversed
            ? 'Tilt up: Pass  ·  Tilt down: Got it'
            : 'Tilt up: Got it  ·  Tilt down: Pass';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.screen_rotation_alt_rounded,
              size: getProportionateScreenWidth(16),
              color: AppColors.secondary,
            ),
            SizedBox(width: getProportionateScreenWidth(6)),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  hint,
                  style: AppTypography.body.copyWith(
                    color: AppColors.secondary,
                    fontSize: getProportionateScreenWidth(13),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
