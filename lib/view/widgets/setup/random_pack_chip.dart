import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';

class RandomPackChip extends StatelessWidget {
  const RandomPackChip({super.key});

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(22));
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowSoft,
                offset: Offset(0, getProportionateScreenHeight(4)),
                blurRadius: getProportionateScreenWidth(12),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () {
              const List<WordCategory> packs = [
                WordCategory.animals,
                WordCategory.movies,
                WordCategory.actions,
                WordCategory.food,
              ];
              final WordCategory pick = packs[
                  DateTime.now().millisecondsSinceEpoch % packs.length];
              context.read<GameViewModel>().startRoundWithCategory(pick);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(18),
                vertical: getProportionateScreenHeight(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    size: getProportionateScreenWidth(18),
                    color: AppColors.blue,
                  ),
                  SizedBox(width: getProportionateScreenWidth(6)),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Surprise me',
                        style: AppTypography.label.copyWith(
                          color: AppColors.blue,
                          fontSize: getProportionateScreenWidth(13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
