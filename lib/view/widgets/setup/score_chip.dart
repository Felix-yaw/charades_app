import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

class ScoreChip extends StatelessWidget {
  const ScoreChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, int>(
      selector: (context, gameViewModel) => gameViewModel.totalScore,
      builder: (context, totalScore, child) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenHeight(6),
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(18)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowSoft,
                offset: Offset(0, getProportionateScreenHeight(4)),
                blurRadius: getProportionateScreenWidth(10),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '🪙',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  height: 1,
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(6)),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$totalScore',
                      style: AppTypography.title.copyWith(
                        color: AppColors.ink,
                        fontSize: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Score',
                      style: AppTypography.body.copyWith(
                        color: AppColors.secondary,
                        fontSize: getProportionateScreenWidth(9),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
