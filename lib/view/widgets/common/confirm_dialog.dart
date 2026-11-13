import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/gradients.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';
import 'gradient_button.dart';
import 'soft_button.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
}) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(24),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(28)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(dialogContext).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(24),
              vertical: getProportionateScreenHeight(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: getProportionateScreenWidth(56),
                    height: getProportionateScreenWidth(56),
                    decoration: const BoxDecoration(
                      gradient: AppGradients.blueButton,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.flag_rounded,
                      color: AppColors.white,
                      size: getProportionateScreenWidth(28),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(16)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.heading.copyWith(color: AppColors.ink),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTypography.body.copyWith(
                    color: AppColors.secondary,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(24)),
                GradientButton(
                  label: confirmLabel,
                  gradient: AppGradients.blueButton,
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                SoftButton(
                  label: cancelLabel,
                  foregroundColor: AppColors.ink,
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  return confirmed ?? false;
}
