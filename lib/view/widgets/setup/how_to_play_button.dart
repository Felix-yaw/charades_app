import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/size_config.dart';

class HowToPlayButton extends StatelessWidget {
  const HowToPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius:
              BorderRadius.circular(getProportionateScreenWidth(22)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowSoft,
              offset: Offset(0, getProportionateScreenHeight(4)),
              blurRadius: getProportionateScreenWidth(12),
            ),
          ],
        ),
        child: InkWell(
          borderRadius:
              BorderRadius.circular(getProportionateScreenWidth(22)),
          onTap: () => showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(24)),
              ),
              title: Text(
                'How to play',
                style: AppTypography.heading.copyWith(color: AppColors.ink),
              ),
              content: Text(
                'Pick a pack and act out the word — no talking, no pointing!\n\n'
                'Tilt the phone up for Got it and down for Pass, or use the '
                'buttons. Clear as many words as you can before the timer runs '
                'out.',
                style: AppTypography.body
                    .copyWith(color: AppColors.secondary, height: 1.5),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'Got it',
                    style: AppTypography.title.copyWith(color: AppColors.blue),
                  ),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16),
              vertical: getProportionateScreenHeight(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.help_outline_rounded,
                  size: getProportionateScreenWidth(18),
                  color: AppColors.blue,
                ),
                SizedBox(width: getProportionateScreenWidth(6)),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'How to play?',
                      style: AppTypography.label.copyWith(
                        color: AppColors.blue,
                        fontSize: getProportionateScreenWidth(13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
