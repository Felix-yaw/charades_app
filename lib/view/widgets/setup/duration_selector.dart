import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/section_title.dart';
import 'duration_option.dart';

class DurationSelector extends StatelessWidget {
  const DurationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Round duration'),
        SizedBox(height: getProportionateScreenHeight(12)),
        Selector<GameViewModel, int>(
          selector: (context, gameViewModel) => gameViewModel.roundSeconds,
          builder: (context, roundSeconds, child) {
            return Row(
              children: [
                for (final int seconds in GameViewModel.roundDurationOptions) ...[
                  Expanded(
                    child: DurationOption(
                      label: '${seconds}s',
                      isSelected: seconds == roundSeconds,
                      onTap: () => context
                          .read<GameViewModel>()
                          .selectRoundSeconds(seconds),
                    ),
                  ),
                  if (seconds != GameViewModel.roundDurationOptions.last)
                    SizedBox(width: getProportionateScreenWidth(10)),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
