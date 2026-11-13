import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

String formatRoundTime(int seconds) {
  final int minutes = seconds ~/ 60;
  final int remaining = seconds % 60;
  return '$minutes:${remaining.toString().padLeft(2, '0')}';
}

class TimerChip extends StatelessWidget {
  const TimerChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, int>(
      selector: (context, gameViewModel) => gameViewModel.remainingSeconds,
      builder: (context, remainingSeconds, child) {
        final bool isLow = remainingSeconds <= 10;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(12),
            vertical: getProportionateScreenHeight(7),
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer_rounded,
                size: getProportionateScreenWidth(18),
                color: isLow ? AppColors.danger : AppColors.blue,
              ),
              SizedBox(width: getProportionateScreenWidth(5)),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formatRoundTime(remainingSeconds),
                  style: AppTypography.title.copyWith(
                    color: isLow ? AppColors.danger : AppColors.ink,
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
