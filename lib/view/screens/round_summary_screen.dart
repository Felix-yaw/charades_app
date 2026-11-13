import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../widgets/common/soft_background.dart';
import '../widgets/summary/change_settings_button.dart';
import '../widgets/summary/guessed_section.dart';
import '../widgets/summary/passed_section.dart';
import '../widgets/summary/play_again_button.dart';
import '../widgets/summary/summary_score_section.dart';

class RoundSummaryScreen extends StatelessWidget {
  const RoundSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundTop,
      body: SoftBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: getProportionateScreenHeight(28)),
                const SummaryScoreSection(),
                SizedBox(height: getProportionateScreenHeight(32)),
                const GuessedSection(),
                SizedBox(height: getProportionateScreenHeight(20)),
                const PassedSection(),
                SizedBox(height: getProportionateScreenHeight(36)),
                const PlayAgainButton(),
                SizedBox(height: getProportionateScreenHeight(12)),
                const ChangeSettingsButton(),
                SizedBox(height: getProportionateScreenHeight(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
