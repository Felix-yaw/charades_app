import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/section_title.dart';
import 'stat_tile.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Statistics'),
        SizedBox(height: getProportionateScreenHeight(14)),
        Selector<GameViewModel, (int, int)>(
          selector: (context, gameViewModel) => (
            gameViewModel.bestScore,
            gameViewModel.roundsPlayed,
          ),
          builder: (context, stats, child) {
            final (int bestScore, int roundsPlayed) = stats;
            return Row(
              children: [
                Expanded(
                  child: StatTile(
                    emoji: '👑',
                    label: 'Best score',
                    value: '$bestScore',
                    gradient: AppGradients.purpleTile,
                    starburstColor: AppColors.white,
                    valueColor: AppColors.purple,
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(14)),
                Expanded(
                  child: StatTile(
                    emoji: '🎮',
                    label: 'Rounds',
                    value: '$roundsPlayed',
                    gradient: AppGradients.greenTile,
                    starburstColor: AppColors.white,
                    valueColor: AppColors.green,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
