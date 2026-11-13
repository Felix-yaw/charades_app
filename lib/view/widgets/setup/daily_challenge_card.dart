import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/gradients.dart';
import '../../../viewmodels/game_view_model.dart';
import 'feature_card.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      emoji: '📅',
      title: 'Daily\nChallenge',
      subtitle: '5 words · 60s',
      gradient: AppGradients.dailyChallenge,
      onTap: () => context.read<GameViewModel>().startDailyChallenge(),
    );
  }
}
