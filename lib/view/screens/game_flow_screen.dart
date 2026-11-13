import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/game_view_model.dart';
import 'game_screen.dart';
import 'home_shell_screen.dart';
import 'round_summary_screen.dart';

class GameFlowScreen extends StatefulWidget {
  const GameFlowScreen({super.key});

  @override
  State<GameFlowScreen> createState() => _GameFlowScreenState();
}

class _GameFlowScreenState extends State<GameFlowScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameViewModel>().restorePersistedState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<GameViewModel, GamePhase>(
      selector: (context, gameViewModel) => gameViewModel.phase,
      builder: (context, phase, child) {
        switch (phase) {
          case GamePhase.setup:
            return const HomeShellScreen();
          case GamePhase.countdown:
          case GamePhase.playing:
            return const GameScreen();
          case GamePhase.roundOver:
            return const RoundSummaryScreen();
        }
      },
    );
  }
}
