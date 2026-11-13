import 'dart:async';
import 'dart:math' as math;

import 'package:charades_app/data/services/motion_service.dart';
import 'package:charades_app/models/accelerometer_sample.dart';

class FakeMotionService implements MotionService {
  final StreamController<AccelerometerSample> _controller =
      StreamController<AccelerometerSample>.broadcast(sync: true);

  @override
  Stream<AccelerometerSample> get samples => _controller.stream;

  void emitTilt(double angleRadians, DateTime timestamp) {
    _controller.add(
      AccelerometerSample(
        x: 0,
        y: math.sin(angleRadians),
        z: math.cos(angleRadians),
        timestamp: timestamp,
      ),
    );
  }
}
