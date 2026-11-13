import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import '../common/gradient_button.dart';
import 'duration_selector.dart';
import 'motion_toggle_tile.dart';

Future<void> showSettingsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => const SettingsSheet(),
  );
}

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(24),
          vertical: getProportionateScreenHeight(20),
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(getProportionateScreenWidth(28)),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: getProportionateScreenWidth(48),
                  height: getProportionateScreenHeight(5),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSoft,
                    borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(3)),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(18)),
              Text(
                'Settings',
                style: AppTypography.heading.copyWith(color: AppColors.white),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              const DurationSelector(),
              SizedBox(height: getProportionateScreenHeight(20)),
              const MotionToggleTile(),
              SizedBox(height: getProportionateScreenHeight(24)),
              GradientButton(
                label: 'Done',
                gradient: AppGradients.yellowButton,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
            ],
          ),
        ),
      ),
    );
  }
}
