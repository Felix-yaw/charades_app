import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/home_shell_viewmodel.dart';
import 'filter_chip.dart';

class PackFilterRow extends StatelessWidget {
  const PackFilterRow({super.key});

  static const List<(String, WordCategory?)> _filters = [
    ('All', null),
    ('Animals', WordCategory.animals),
    ('Movies', WordCategory.movies),
    ('Actions', WordCategory.actions),
    ('Food', WordCategory.food),
  ];

  static const Map<WordCategory?, Color> _bubbleColors = {
    null: AppColors.purpleSoft,
    WordCategory.animals: AppColors.pinkSoft,
    WordCategory.movies: AppColors.purpleSoft,
    WordCategory.actions: AppColors.blueSoft,
    WordCategory.food: AppColors.yellowSoft,
  };

  static const Map<WordCategory?, String> _emojis = {
    null: '🎲',
    WordCategory.animals: '🦁',
    WordCategory.movies: '🎬',
    WordCategory.actions: '🏃',
    WordCategory.food: '🍔',
  };

  @override
  Widget build(BuildContext context) {
    return Selector<HomeShellViewModel, WordCategory?>(
      selector: (context, homeShellViewModel) => homeShellViewModel.packFilter,
      builder: (context, packFilter, child) {
        return SizedBox(
          height: getProportionateScreenHeight(42),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final (String label, WordCategory? category) in _filters) ...[
                FilterChipItem(
                  label: label,
                  emoji: _emojis[category]!,
                  bubbleColor: _bubbleColors[category]!,
                  isSelected: packFilter == category,
                  onTap: () => context
                      .read<HomeShellViewModel>()
                      .setPackFilter(category),
                ),
                SizedBox(width: getProportionateScreenWidth(8)),
              ],
            ],
          ),
        );
      },
    );
  }
}
