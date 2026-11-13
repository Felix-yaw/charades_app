import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../core/utils/size_config.dart';
import '../widgets/common/section_title.dart';
import '../widgets/custom_words/custom_word_count.dart';
import '../widgets/custom_words/custom_word_input.dart';
import '../widgets/custom_words/custom_word_list.dart';
import '../widgets/custom_words/play_my_words_button.dart';

class CustomWordsScreen extends StatelessWidget {
  const CustomWordsScreen({super.key});

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
          SizedBox(height: getProportionateScreenHeight(12)),
          const SectionTitle('My Words'),
          SizedBox(height: getProportionateScreenHeight(8)),
          Text(
            'Add your own words — they are saved on your device and playable '
            'as the My Words pack.',
            style: AppTypography.body
                .copyWith(color: AppColors.secondary),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          const CustomWordInput(),
          SizedBox(height: getProportionateScreenHeight(14)),
          const CustomWordCount(),
          SizedBox(height: getProportionateScreenHeight(14)),
          const PlayMyWordsButton(),
          SizedBox(height: getProportionateScreenHeight(20)),
          const CustomWordList(),
          SizedBox(height: getProportionateScreenHeight(24)),
        ],
      ),
    );
  }
}
