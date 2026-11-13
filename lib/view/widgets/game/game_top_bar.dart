import 'package:flutter/material.dart';

import '../../../core/utils/size_config.dart';
import 'end_round_button.dart';
import 'score_badge.dart';
import 'timer_chip.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(8),
      ),
      child: Row(
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: const TimerChip(),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(8)),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: const ScoreBadge(),
            ),
          ),
          const Spacer(),
          const EndRoundButton(),
        ],
      ),
    );
  }
}
