import '../../core/utils/tilt_angle.dart';

enum TiltDirection { up, down }

class TiltGestureDetector {
  TiltGestureDetector({
    this.triggerThreshold = 0.52,
    this.rearmThreshold = 0.14,
    this.rearmDelay = const Duration(milliseconds: 1200),
    this.minTriggerInterval = const Duration(milliseconds: 500),
  });

  // ~30 degrees of tilt away from the calibrated hold pose fires a gesture.
  final double triggerThreshold;

  // ~8 degrees of settle back toward the hold pose re-arms the detector.
  final double rearmThreshold;

  // Holding a tilted pose re-calibrates after this delay so play can continue
  // without returning to neutral first.
  final Duration rearmDelay;

  // A single physical flick must not fire two rapid gestures.
  final Duration minTriggerInterval;

  double? _baselineAngle;
  bool _armed = true;
  DateTime? _lastTrigger;

  void reset() {
    _baselineAngle = null;
    _armed = true;
    _lastTrigger = null;
  }

  TiltDirection? processSample(double angle, DateTime timestamp) {
    if (_baselineAngle == null) {
      _baselineAngle = angle;
      return null;
    }
    final double delta = shortestAngleDelta(_baselineAngle!, angle);

    if (!_armed) {
      if (delta.abs() <= rearmThreshold) {
        _armed = true;
      } else if (_lastTrigger != null &&
          timestamp.difference(_lastTrigger!) >= rearmDelay) {
        _baselineAngle = angle;
        _armed = true;
      }
      return null;
    }

    if (_lastTrigger != null &&
        timestamp.difference(_lastTrigger!) < minTriggerInterval) {
      return null;
    }
    if (delta >= triggerThreshold) {
      _armed = false;
      _lastTrigger = timestamp;
      return TiltDirection.up;
    }
    if (delta <= -triggerThreshold) {
      _armed = false;
      _lastTrigger = timestamp;
      return TiltDirection.down;
    }
    return null;
  }
}
