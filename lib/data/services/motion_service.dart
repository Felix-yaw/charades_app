import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../models/accelerometer_sample.dart';
import 'empty_motion_service.dart';

abstract interface class MotionService {
  Stream<AccelerometerSample> get samples;
}

// Sensors only exist on phones; everywhere else (tests, desktop, CI) use the
// inert EmptyMotionService so no platform channel is ever touched.
MotionService createDefaultMotionService() {
  if (kIsWeb) return const EmptyMotionService();
  if (Platform.isAndroid || Platform.isIOS) return DeviceMotionService();
  return const EmptyMotionService();
}

class DeviceMotionService implements MotionService {
  DeviceMotionService();

  late final Stream<AccelerometerSample> _samples = accelerometerEventStream(
    samplingPeriod: SensorInterval.gameInterval,
  )
      .map(
        (AccelerometerEvent event) => AccelerometerSample(
          x: event.x,
          y: event.y,
          z: event.z,
          timestamp: event.timestamp,
        ),
      )
      .handleError((Object error, StackTrace stackTrace) {});

  @override
  Stream<AccelerometerSample> get samples => _samples;
}
