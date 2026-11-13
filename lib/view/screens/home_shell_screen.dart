import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/size_config.dart';
import '../../viewmodels/home_shell_viewmodel.dart';
import '../widgets/common/app_bottom_nav_bar.dart';
import '../widgets/common/soft_background.dart';
import '../widgets/setup/home_top_bar.dart';
import 'custom_words_screen.dart';
import 'history_screen.dart';
import 'packs_screen.dart';

class HomeShellScreen extends StatelessWidget {
  const HomeShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundTop,
      body: SoftBackground(
        child: SafeArea(
          child: Column(
            children: [
              const HomeTopBar(),
              Expanded(
                child: Selector<HomeShellViewModel, int>(
                  selector: (context, homeShellViewModel) =>
                      homeShellViewModel.selectedIndex,
                  builder: (context, selectedIndex, child) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Offstage(
                          offstage: selectedIndex != 0,
                          child: const CustomWordsScreen(),
                        ),
                        Offstage(
                          offstage: selectedIndex != 1,
                          child: const PacksScreen(),
                        ),
                        Offstage(
                          offstage: selectedIndex != 2,
                          child: const HistoryScreen(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const AppBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}
