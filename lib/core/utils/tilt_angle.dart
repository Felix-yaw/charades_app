import 'dart:math' as math;

// Rotation of the device about its horizontal (side-to-side) axis, derived from
// gravity. Calibration against a captured baseline makes the value independent
// of platform axis sign conventions.
double tiltAngleFromAccelerometer(double y, double z) => math.atan2(y, z);

// Signed shortest angular distance from [from] to [to], within (-pi, pi].
double shortestAngleDelta(double from, double to) =>
    math.atan2(math.sin(to - from), math.cos(to - from));
