import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';

class CustomWordRow extends StatelessWidget {
  const CustomWordRow({super.key, required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius:
            BorderRadius.circular(getProportionateScreenWidth(16)),
        border: Border.all(color: AppColors.blueSoft),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              word,
              style: AppTypography.label.copyWith(color: AppColors.ink),
            ),
          ),
          IconButton(
            tooltip: 'Remove',
            icon: Icon(
              Icons.close_rounded,
              size: getProportionateScreenWidth(20),
              color: AppColors.secondary,
            ),
            onPressed: () => context.read<GameViewModel>().removeCustomWord(word),
          ),
        ],
      ),
    );
  }
}
