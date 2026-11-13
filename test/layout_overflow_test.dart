import 'package:charades_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const List<Size> deviceSizes = [
  Size(320, 568),
  Size(390, 844),
  Size(1024, 1366),
];
const List<double> textScales = [1.0, 1.5, 2.0];

void main() {
  for (final Size deviceSize in deviceSizes) {
    for (final double textScale in textScales) {
      testWidgets(
          'no overflow at ${deviceSize.width.toInt()}x${deviceSize.height.toInt()} '
          '@ ${textScale}x text', (WidgetTester tester) async {
        tester.view.physicalSize = deviceSize;
        tester.view.devicePixelRatio = 1.0;
        tester.platformDispatcher.textScaleFactorTestValue = textScale;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearAllTestValues);

        await tester.pumpWidget(const CharadesApp());
        await tester.pump();
        expect(tester.takeException(), isNull, reason: 'home screen overflow');

        await tester.tap(find.byTooltip('Custom words'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull,
            reason: 'custom words tab overflow');

        await tester.tap(find.byTooltip('History'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'history tab overflow');

        await tester.tap(find.byTooltip('Packs'));
        await tester.pumpAndSettle();

        await tester.tap(find.byTooltip('Settings'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'settings sheet overflow');

        await tester.ensureVisible(find.text('Done'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Done'));
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.text('Animals'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Animals'));
        await tester.pump(const Duration(seconds: 4));
        expect(tester.takeException(), isNull, reason: 'game screen overflow');

        await tester.tap(find.byTooltip('End round'));
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text('End round'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('End round'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull,
            reason: 'round summary screen overflow');
      });
    }
  }
}
