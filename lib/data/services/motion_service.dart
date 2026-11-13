import 'package:sensors_plus/sensors_plus.dart';

import '../../models/accelerometer_sample.dart';

abstract interface class MotionService {
  Stream<AccelerometerSample> get samples;
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
