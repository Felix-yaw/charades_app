import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../core/utils/size_config.dart';
import '../widgets/setup/category_selector.dart';
import '../widgets/setup/how_to_play_button.dart';
import '../widgets/setup/pack_filter_row.dart';
import '../widgets/setup/random_pack_chip.dart';
import '../widgets/setup/stats_section.dart';
import '../widgets/setup/super_mix_banner.dart';

class PacksScreen extends StatelessWidget {
  const PacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: getProportionateScreenHeight(8)),
          const SuperMixBanner(),
          SizedBox(height: getProportionateScreenHeight(24)),
          const StatsSection(),
          SizedBox(height: getProportionateScreenHeight(24)),
          Row(
            children: [
              Expanded(
                child: Text(
                  'PICK A PACK',
                  style:
                      AppTypography.heading.copyWith(color: AppColors.ink),
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: const HowToPlayButton(),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
          const RandomPackChip(),
          SizedBox(height: getProportionateScreenHeight(16)),
          const PackFilterRow(),
          SizedBox(height: getProportionateScreenHeight(14)),
          const CategorySelector(),
          SizedBox(height: getProportionateScreenHeight(24)),
        ],
      ),
    );
  }
}
