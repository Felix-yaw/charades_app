import 'package:flutter/animation.dart';

class AppDurations {
  const AppDurations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 600);
}

class AppCurves {
  const AppCurves._();

  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bouncy = Curves.easeOutBack;
}
