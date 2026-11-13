import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../core/utils/size_config.dart';
import '../widgets/common/section_title.dart';
import '../widgets/history/history_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
          const SectionTitle('History'),
          SizedBox(height: getProportionateScreenHeight(8)),
          Text(
            'Your finished rounds, newest first.',
            style: AppTypography.body
                .copyWith(color: AppColors.secondary),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          const HistoryList(),
          SizedBox(height: getProportionateScreenHeight(24)),
        ],
      ),
    );
  }
}
