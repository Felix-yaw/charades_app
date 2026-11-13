import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/animation.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'countdown_display.dart';
import 'word_card_display.dart';

class RoundStage extends StatelessWidget {
  const RoundStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, (GamePhase, WordCard?, int)>(
      selector: (context, gameViewModel) => (
        gameViewModel.phase,
        gameViewModel.currentCard,
        gameViewModel.countdownValue,
      ),
      builder: (context, stageState, child) {
        final (GamePhase phase, WordCard? currentCard, int countdownValue) =
            stageState;
        return AnimatedSwitcher(
          duration: AppDurations.medium,
          switchInCurve: AppCurves.easeOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.08),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: phase == GamePhase.countdown
              ? CountdownDisplay(
                  key: const ValueKey<String>('countdown'),
                  countdownValue: countdownValue,
                )
              : currentCard != null
                  ? WordCardDisplay(
                      key: ValueKey<String>(currentCard.text),
                      wordCard: currentCard,
                    )
                  : const SizedBox.shrink(key: ValueKey<String>('empty')),
        );
      },
    );
  }
}
