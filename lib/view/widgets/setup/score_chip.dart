import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
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
            vertical: getProportionateScreenHeight(7),
          ),
          decoration: BoxDecoration(
            gradient: AppGradients.blueButton,
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
            children: [
              Text('⭐', style: TextStyle(fontSize: getProportionateScreenWidth(14), height: 1)),
              SizedBox(width: getProportionateScreenWidth(5)),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$totalScore',
                  style: AppTypography.title.copyWith(
                    color: AppColors.white,
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
