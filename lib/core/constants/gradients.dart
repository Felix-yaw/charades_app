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

  static const RadialGradient glowBlue = RadialGradient(
    colors: [Color(0x335B8CF7), Color(0x005B8CF7)],
  );

  static const RadialGradient glowPurple = RadialGradient(
    colors: [Color(0x2EC651E8), Color(0x00C651E8)],
  );
}
