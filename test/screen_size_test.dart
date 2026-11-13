import 'package:charades_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('layout re-scales when the window size changes',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CharadesApp());
    await tester.pumpAndSettle();

    final double fontHeightBefore =
        tester.getSize(find.text('PICK A PACK')).height;

    tester.view.physicalSize = const Size(720, 1600);
    tester.binding.handleMetricsChanged();
    await tester.pumpAndSettle();

    final double fontHeightAfter =
        tester.getSize(find.text('PICK A PACK')).height;

    expect(fontHeightAfter, greaterThan(fontHeightBefore));
  });
}
