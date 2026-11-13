import 'package:charades_app/viewmodels/tilt_gesture_detector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TiltGestureDetector', () {
    final DateTime base = DateTime(2026, 1, 1);
    Duration at(int milliseconds) => Duration(milliseconds: milliseconds);

    test('first sample calibrates the hold pose', () {
      final TiltGestureDetector detector = TiltGestureDetector();

      expect(detector.processSample(1.2, base), isNull);
      expect(detector.processSample(1.2 + 0.1, base.add(at(200))), isNull);
      expect(
        detector.processSample(1.2 + 0.6, base.add(at(400))),
        TiltDirection.up,
      );
    });

    test('tilt up fires once and stays disarmed until the hold pose returns',
        () {
      final TiltGestureDetector detector = TiltGestureDetector();
      detector.processSample(0, base);

      expect(
        detector.processSample(0.6, base.add(at(200))),
        TiltDirection.up,
      );
      expect(
        detector.processSample(0.7, base.add(at(400))),
        isNull,
      );
      expect(
        detector.processSample(0.8, base.add(at(600))),
        isNull,
      );

      detector.processSample(0, base.add(at(800)));
      expect(
        detector.processSample(0.6, base.add(at(1000))),
        TiltDirection.up,
      );
    });

    test('tilt down fires a pass gesture', () {
      final TiltGestureDetector detector = TiltGestureDetector();
      detector.processSample(0, base);

      expect(
        detector.processSample(-0.6, base.add(at(200))),
        TiltDirection.down,
      );
    });

    test('holding a tilted pose re-calibrates after the rearm delay', () {
      final TiltGestureDetector detector = TiltGestureDetector();
      detector.processSample(0, base);
      detector.processSample(0.6, base.add(at(200)));

      expect(
        detector.processSample(0.6, base.add(at(1500))),
        isNull,
      );
      expect(
        detector.processSample(1.2, base.add(at(1700))),
        TiltDirection.up,
      );
    });

    test('rapid gestures within the trigger interval are suppressed', () {
      final TiltGestureDetector detector = TiltGestureDetector();
      detector.processSample(0, base);

      expect(
        detector.processSample(0.6, base.add(at(100))),
        TiltDirection.up,
      );
      detector.processSample(0, base.add(at(200)));
      expect(
        detector.processSample(0.6, base.add(at(300))),
        isNull,
      );

      expect(
        detector.processSample(0, base.add(at(900))),
        isNull,
      );
      expect(
        detector.processSample(0.6, base.add(at(1000))),
        TiltDirection.up,
      );
    });

    test('reset clears the calibration', () {
      final TiltGestureDetector detector = TiltGestureDetector();
      detector.processSample(0, base);
      detector.processSample(0.6, base.add(at(200)));

      detector.reset();
      expect(
        detector.processSample(0.6, base.add(at(400))),
        isNull,
      );
    });
  });
}
