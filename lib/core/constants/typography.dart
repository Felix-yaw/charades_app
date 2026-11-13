import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Fredoka';

  static TextStyle _style({
    required double size,
    required double weight,
    Color color = Colors.white,
    double height = 1.2,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: getProportionateScreenWidth(size),
      fontWeight: FontWeight.w700,
      fontVariations: [FontVariation('wght', weight)],
      color: color,
      height: height,
    );
  }

  static TextStyle get wordmark => _style(size: 30, weight: 700);

  static TextStyle get display => _style(size: 52, weight: 700, height: 1.1);

  static TextStyle get heading => _style(size: 24, weight: 700);

  static TextStyle get title => _style(size: 19, weight: 600);

  static TextStyle get label => _style(size: 15, weight: 600);

  static TextStyle get body => _style(size: 14, weight: 500);

  static TextStyle get button => _style(size: 19, weight: 700);
}
