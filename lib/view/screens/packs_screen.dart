import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../core/utils/size_config.dart';
import '../widgets/common/section_title.dart';
import '../widgets/setup/category_selector.dart';
import '../widgets/setup/daily_challenge_card.dart';
import '../widgets/setup/game_modes_grid.dart';
import '../widgets/setup/home_hero.dart';
import '../widgets/setup/how_to_play_button.dart';
import '../widgets/setup/pack_filter_row.dart';
import '../widgets/setup/party_roulette_card.dart';
import '../widgets/setup/play_now_button.dart';

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
          const HomeHero(),
          SizedBox(height: getProportionateScreenHeight(16)),
          const PlayNowButton(),
          SizedBox(height: getProportionateScreenHeight(18)),
          Row(
            children: [
              const Expanded(child: DailyChallengeCard()),
              SizedBox(width: getProportionateScreenWidth(12)),
              const Expanded(child: PartyRouletteCard()),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(24)),
          const SectionTitle('Game Modes'),
          SizedBox(height: getProportionateScreenHeight(14)),
          const GameModesGrid(),
          SizedBox(height: getProportionateScreenHeight(24)),
          Row(
            children: [
              Expanded(
                child: Text(
                  'PICK A PACK',
                  style:
                      AppTypography.heading.copyWith(color: AppColors.white),
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
          SizedBox(height: getProportionateScreenHeight(14)),
          const PackFilterRow(),
          SizedBox(height: getProportionateScreenHeight(14)),
          const CategorySelector(),
          SizedBox(height: getProportionateScreenHeight(24)),
        ],
      ),
    );
  }
}
