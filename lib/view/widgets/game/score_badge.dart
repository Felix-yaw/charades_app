import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/animation.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, int>(
      selector: (context, gameViewModel) => gameViewModel.score,
      builder: (context, score, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenHeight(7),
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(16)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowSoft,
                offset: Offset(0, getProportionateScreenHeight(4)),
                blurRadius: getProportionateScreenWidth(10),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedSwitcher(
              duration: AppDurations.fast,
              switchInCurve: AppCurves.bouncy,
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                'Score: $score',
                key: ValueKey<int>(score),
                style: AppTypography.title.copyWith(
                  color: AppColors.white,
                  fontSize: getProportionateScreenWidth(15),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
