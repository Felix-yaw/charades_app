import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/colors.dart';
import 'core/constants/typography.dart';
import 'view/screens/game_flow_screen.dart';
import 'view/widgets/common/app_metrics_scope.dart';
import 'viewmodels/game_view_model.dart';
import 'viewmodels/home_shell_viewmodel.dart';

void main() {
  runApp(const CharadesApp());
}

class CharadesApp extends StatelessWidget {
  const CharadesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameViewModel>(
          create: (context) => GameViewModel(),
        ),
        ChangeNotifierProvider<HomeShellViewModel>(
          create: (context) => HomeShellViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Charades',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: AppTypography.fontFamily,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.blue,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: AppColors.backgroundTop,
        ),
        home: const AppMetricsScope(
          child: GameFlowScreen(),
        ),
      ),
    );
  }
}
