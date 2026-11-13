import 'package:flutter/material.dart';

import 'colors.dart';

class AppGradients {
  const AppGradients._();

  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
  );

  static const LinearGradient blueButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5B8CF7), AppColors.blueDark],
  );

  static const LinearGradient yellowButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFD86B), AppColors.yellow],
  );

  static const LinearGradient greenButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA8DC63), AppColors.green],
  );

  static const LinearGradient purpleTile = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC651E8), AppColors.purple],
  );

  static const LinearGradient greenTile = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC6E765), Color(0xFFA5D64A)],
  );

  static const LinearGradient dailyChallenge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B5CF6), Color(0xFF5B21B6)],
  );

  static const LinearGradient roulette = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
  );

  static const LinearGradient reverseMode = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2DD4BF), Color(0xFF0D9488)],
  );

  static const RadialGradient glowBlue = RadialGradient(
    colors: [Color(0x663D6FF2), Color(0x003D6FF2)],
  );

  static const RadialGradient glowPurple = RadialGradient(
    colors: [Color(0x66C651E8), Color(0x00C651E8)],
  );
}
