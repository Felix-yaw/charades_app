import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/round_record.dart';
import '../../../viewmodels/game_view_model.dart';
import 'history_tile.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, List<RoundRecord>>(
      selector: (context, gameViewModel) => gameViewModel.history,
      builder: (context, history, child) {
        if (history.isEmpty) {
          return Text(
            'No rounds yet. Play a round and it will show up here.',
            style: AppTypography.body
                .copyWith(color: AppColors.secondary),
          );
        }
        return Column(
          children: [
            for (final RoundRecord record in history) ...[
              HistoryTile(record: record),
              SizedBox(height: getProportionateScreenHeight(10)),
            ],
          ],
        );
      },
    );
  }
}
