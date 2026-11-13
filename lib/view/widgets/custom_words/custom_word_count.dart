import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../viewmodels/game_view_model.dart';

class CustomWordCount extends StatelessWidget {
  const CustomWordCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, int>(
      selector: (context, gameViewModel) => gameViewModel.customWords.length,
      builder: (context, wordCount, child) {
        final String label =
            wordCount == 1 ? '1 word in your pack' : '$wordCount words in your pack';
        return Text(
          wordCount == 0 ? 'Your pack is empty.' : label,
          style: AppTypography.label.copyWith(color: AppColors.blue),
        );
      },
    );
  }
}
