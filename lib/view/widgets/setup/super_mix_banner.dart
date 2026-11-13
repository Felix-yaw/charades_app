import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../../../models/word_card.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/star_burst.dart';
import 'question_mark.dart';

class SuperMixBanner extends StatelessWidget {
  const SuperMixBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(getProportionateScreenWidth(28));
    return Semantics(
      button: true,
      label: 'SUPER MIX',
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppGradients.blueButton,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                offset: Offset(0, getProportionateScreenHeight(10)),
                blurRadius: getProportionateScreenWidth(22),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: () => context
                .read<GameViewModel>()
                .startRoundWithCategory(WordCategory.all),
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUPER MIX',
                          style: AppTypography.heading
                              .copyWith(color: AppColors.white),
                        ),
                        SizedBox(height: getProportionateScreenHeight(6)),
                        Text(
                          'Mix of questions for all topics',
                          style: AppTypography.body.copyWith(
                            color: AppColors.white,
                            fontSize: getProportionateScreenWidth(13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(110),
                    height: getProportionateScreenWidth(84),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned.fill(
                          child: StarBurst(color: Color(0x2EFFFFFF)),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              QuestionMark(
                                fontSize: getProportionateScreenWidth(28),
                                color: AppColors.white,
                              ),
                              QuestionMark(
                                fontSize: getProportionateScreenWidth(48),
                                color: AppColors.white,
                              ),
                              QuestionMark(
                                fontSize: getProportionateScreenWidth(28),
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
