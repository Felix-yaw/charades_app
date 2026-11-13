import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';
import 'settings_sheet.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowSoft,
            offset: Offset(0, getProportionateScreenHeight(4)),
            blurRadius: getProportionateScreenWidth(12),
          ),
        ],
      ),
      child: IconButton(
        tooltip: 'Settings',
        icon: Icon(
          Icons.settings_rounded,
          size: getProportionateScreenWidth(24),
          color: AppColors.blue,
        ),
        onPressed: () => showSettingsSheet(context),
      ),
    );
  }
}
