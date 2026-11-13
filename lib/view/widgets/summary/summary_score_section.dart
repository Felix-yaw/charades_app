import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/animation.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/star_burst.dart';

class SummaryScoreSection extends StatelessWidget {
  const SummaryScoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, int>(
      selector: (context, gameViewModel) => gameViewModel.score,
      builder: (context, score, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.7, end: 1),
          duration: AppDurations.slow,
          curve: AppCurves.bouncy,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale.clamp(0, 1.1), child: child);
          },
          child: Column(
            children: [
              Text(
                '🏆',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(56),
                  height: 1,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              Text(
                'Round over!',
                textAlign: TextAlign.center,
                style: AppTypography.display.copyWith(color: AppColors.white),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(30),
                ),
                decoration: BoxDecoration(
                  gradient: AppGradients.purpleTile,
                  borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(32)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      offset: Offset(0, getProportionateScreenHeight(10)),
                      blurRadius: getProportionateScreenWidth(24),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Positioned.fill(
                      child: StarBurst(color: Color(0x2EFFFFFF)),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Score: $score',
                        textAlign: TextAlign.center,
                        style: AppTypography.display.copyWith(
                          color: AppColors.white,
                          fontSize: getProportionateScreenWidth(44),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
