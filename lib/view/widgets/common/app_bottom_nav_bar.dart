import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/size_config.dart';
import '../../../viewmodels/home_shell_viewmodel.dart';
import 'bottom_nav_item.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16),
        vertical: getProportionateScreenHeight(8),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(6),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius:
            BorderRadius.circular(getProportionateScreenWidth(26)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(0, getProportionateScreenHeight(6)),
            blurRadius: getProportionateScreenWidth(18),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Selector<HomeShellViewModel, int>(
          selector: (context, homeShellViewModel) =>
              homeShellViewModel.selectedIndex,
          builder: (context, selectedIndex, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BottomNavItem(
                    icon: Icons.edit_rounded,
                    label: 'Words',
                    tooltip: 'Custom words',
                    isSelected: selectedIndex == 0,
                    onTap: () =>
                        context.read<HomeShellViewModel>().selectTab(0),
                  ),
                ),
                Expanded(
                  child: BottomNavItem(
                    icon: Icons.grid_view_rounded,
                    label: 'Packs',
                    tooltip: 'Packs',
                    isSelected: selectedIndex == 1,
                    onTap: () =>
                        context.read<HomeShellViewModel>().selectTab(1),
                  ),
                ),
                Expanded(
                  child: BottomNavItem(
                    icon: Icons.history_rounded,
                    label: 'History',
                    tooltip: 'History',
                    isSelected: selectedIndex == 2,
                    onTap: () =>
                        context.read<HomeShellViewModel>().selectTab(2),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
