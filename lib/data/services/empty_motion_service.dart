import '../../models/accelerometer_sample.dart';
import 'motion_service.dart';

class EmptyMotionService implements MotionService {
  const EmptyMotionService();

  @override
  Stream<AccelerometerSample> get samples => const Stream.empty();
}
