import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import 'category_tile.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  static const List<WordCategory> _packCategories = [
    WordCategory.animals,
    WordCategory.movies,
    WordCategory.actions,
    WordCategory.food,
  ];

  static const Map<WordCategory, String> _categoryEmojis = {
    WordCategory.animals: '🦁',
    WordCategory.movies: '🎬',
    WordCategory.actions: '🏃',
    WordCategory.food: '🍔',
    WordCategory.custom: '✍️',
  };

  static const Map<WordCategory, Color> _bubbleColors = {
    WordCategory.animals: AppColors.pinkSoft,
    WordCategory.movies: AppColors.purpleSoft,
    WordCategory.actions: AppColors.blueSoft,
    WordCategory.food: AppColors.yellowSoft,
    WordCategory.custom: AppColors.greenSoft,
  };

  static const Map<WordCategory, Color> _starburstColors = {
    WordCategory.animals: Color(0x59FFFFFF),
    WordCategory.movies: Color(0x59FFFFFF),
    WordCategory.actions: Color(0x59FFFFFF),
    WordCategory.food: Color(0x59FFFFFF),
    WordCategory.custom: Color(0x59FFFFFF),
  };

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, bool>(
      selector: (context, gameViewModel) =>
          gameViewModel.customWords.isNotEmpty,
      builder: (context, hasCustomWords, child) {
        final List<WordCategory> categories = [
          ..._packCategories,
          if (hasCustomWords) WordCategory.custom,
        ];
        return Wrap(
          spacing: getProportionateScreenWidth(12),
          runSpacing: getProportionateScreenHeight(12),
          children: [
            for (final WordCategory category in categories)
              SizedBox(
                width: getProportionateScreenWidth(142),
                child: CategoryTile(
                  label: category.label,
                  emoji: _categoryEmojis[category]!,
                  bubbleColor: _bubbleColors[category]!,
                  starburstColor: _starburstColors[category]!,
                  onTap: () => context
                      .read<GameViewModel>()
                      .startRoundWithCategory(category),
                ),
              ),
          ],
        );
      },
    );
  }
}
