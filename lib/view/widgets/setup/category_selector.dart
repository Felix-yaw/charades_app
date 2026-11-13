import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import '../../../viewmodels/home_shell_viewmodel.dart';
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

  static const Color _starburstColor = Color(0x59FFFFFF);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeShellViewModel, WordCategory?>(
      selector: (context, homeShellViewModel) => homeShellViewModel.packFilter,
      builder: (context, packFilter, child) {
        return Selector<GameViewModel, bool>(
          selector: (context, gameViewModel) =>
              gameViewModel.customWords.isNotEmpty,
          builder: (context, hasCustomWords, child) {
            final List<WordCategory> categories = [
              for (final WordCategory category in _packCategories)
                if (packFilter == null || packFilter == category) category,
              if (hasCustomWords && packFilter == null) WordCategory.custom,
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
                      starburstColor: _starburstColor,
                      onTap: () => context
                          .read<GameViewModel>()
                          .startRoundWithCategory(category),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
