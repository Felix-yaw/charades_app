import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

class MotionToggleTile extends StatelessWidget {
  const MotionToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, bool>(
      selector: (context, gameViewModel) => gameViewModel.motionControlsEnabled,
      builder: (context, motionControlsEnabled, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(14),
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceSoft,
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(20)),
          ),
          child: Row(
            children: [
              Container(
                width: getProportionateScreenWidth(44),
                height: getProportionateScreenWidth(44),
                decoration: BoxDecoration(
                  gradient: AppGradients.purpleTile,
                  borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(14)),
                ),
                child: Icon(
                  Icons.screen_rotation_alt_rounded,
                  color: AppColors.white,
                  size: getProportionateScreenWidth(24),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tilt controls',
                      style:
                          AppTypography.title.copyWith(color: AppColors.ink),
                    ),
                    SizedBox(height: getProportionateScreenHeight(2)),
                    Text(
                      'Tilt up for Got it, down for Pass.',
                      style: AppTypography.body.copyWith(
                        color: AppColors.secondary,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: motionControlsEnabled,
                activeThumbColor: AppColors.white,
                activeTrackColor: AppColors.blue,
                inactiveThumbColor: AppColors.white,
                inactiveTrackColor: AppColors.secondary,
                onChanged: (bool enabled) => context
                    .read<GameViewModel>()
                    .setMotionControlsEnabled(enabled),
              ),
            ],
          ),
        );
      },
    );
  }
}
