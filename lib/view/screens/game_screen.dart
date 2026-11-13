import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../widgets/common/soft_background.dart';
import '../widgets/game/game_top_bar.dart';
import '../widgets/game/round_action_buttons.dart';
import '../widgets/game/round_stage.dart';
import '../widgets/game/tilt_hint.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundTop,
      body: SoftBackground(
        child: SafeArea(
          child: Column(
            children: [
              const GameTopBar(),
              SizedBox(height: getProportionateScreenHeight(6)),
              const TiltHint(),
              SizedBox(height: getProportionateScreenHeight(10)),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Center(child: RoundStage()),
                ),
              ),
              const RoundActionButtons(),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          ),
        ),
      ),
    );
  }
}
