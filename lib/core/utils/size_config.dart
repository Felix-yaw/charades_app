import 'dart:async' show scheduleMicrotask;
import 'dart:ui' show FlutterView;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

//Must be called on Initialization
class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static bool _initialized = false;
  static Size? _lastRenderSize;

  // Bumped whenever the render size actually changes so the app can remount
  // const subtrees that would otherwise keep stale scaled values.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    _lastRenderSize = _mediaQueryData.size;
    _initialized = true;
    if (screenWidth <= 0 || screenHeight <= 0) {
      captureFromBinding(bumpRevision: false);
    }
  }

  static void captureFromBinding({bool bumpRevision = true}) {
    final Iterable<FlutterView> views =
        WidgetsBinding.instance.platformDispatcher.views;
    if (views.isEmpty) return;
    final FlutterView view = views.first;
    final Size size = view.physicalSize / view.devicePixelRatio;
    if (size.isEmpty) return;
    final bool changed = _lastRenderSize != size;
    screenWidth = size.width;
    screenHeight = size.height;
    orientation = size.width >= size.height
        ? Orientation.landscape
        : Orientation.portrait;
    _mediaQueryData = MediaQueryData.fromView(view);
    _lastRenderSize = size;
    _initialized = true;
    if (bumpRevision && changed) {
      if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
        revision.value += 1;
      } else {
        scheduleMicrotask(() => revision.value += 1);
      }
    }
  }

  static bool get isInitialized => _initialized;
}

// The layout was designed against a 360x800 canvas. Scale from that, but clamp
// the factor so tablets don't balloon the UI (and tiny phones don't over-shrink
// it into unreadable slivers).
const double _minScale = 0.85;
const double _maxScale = 1.2;

double _clampScale(double scale) => scale.clamp(_minScale, _maxScale);

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  final bool isLandscapePhone =
      ScreenSize._mediaQueryData.size.shortestSide < 600 &&
      ScreenSize.orientation == Orientation.landscape;
  final double reference = isLandscapePhone ? 360.0 : 800.0;
  final double scale = _clampScale(ScreenSize.screenHeight / reference);
  return inputHeight * scale;
}

// Get the proportionate width as per screen size
double getProportionateScreenWidth(double inputWidth) {
  final double scale = _clampScale(ScreenSize.screenWidth / 360.0);
  return inputWidth * scale;
}
