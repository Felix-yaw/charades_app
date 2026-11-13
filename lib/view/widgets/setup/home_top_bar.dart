import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import 'player_avatar.dart';
import 'score_chip.dart';
import 'settings_button.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(8),
      ),
      child: Row(
        children: [
          const PlayerAvatar(),
          SizedBox(width: getProportionateScreenWidth(8)),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(14),
                  vertical: getProportionateScreenHeight(8),
                ),
                decoration: BoxDecoration(
                  gradient: AppGradients.blueButton,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(18)),
                ),
                child: Text(
                  '@charades',
                  style: AppTypography.label.copyWith(
                    color: AppColors.white,
                    fontSize: getProportionateScreenWidth(13),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Flexible(
            child: FittedBox(fit: BoxFit.scaleDown, child: ScoreChip()),
          ),
          const SettingsButton(),
        ],
      ),
    );
  }
}
