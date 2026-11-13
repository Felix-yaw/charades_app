import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/game_view_model.dart';
import '../common/confirm_dialog.dart';

class EndRoundButton extends StatelessWidget {
  const EndRoundButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
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
        tooltip: 'End round',
        icon: Icon(
          Icons.close_rounded,
          size: getProportionateScreenWidth(24),
          color: AppColors.white,
        ),
        onPressed: () async {
          final bool confirmed = await showConfirmDialog(
            context,
            title: 'End round?',
            message:
                'The round will end early and your score will be counted.',
            confirmLabel: 'End round',
            cancelLabel: 'Keep playing',
          );
          if (confirmed && context.mounted) {
            context.read<GameViewModel>().endRoundEarly();
          }
        },
      ),
    );
  }
}
