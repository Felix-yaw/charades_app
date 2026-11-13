import 'package:charades_app/main.dart';
import 'package:charades_app/view/widgets/setup/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder packTile(String label) => find.descendant(
      of: find.byType(CategoryTile), matching: find.text(label));

void main() {
  testWidgets('render ui previews', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CharadesApp());
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CharadesApp),
      matchesGoldenFile('goldens/1_home.png'),
    );

    await tester.tap(find.byTooltip('Custom words'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Unicorn');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Play My Words'));
    await tester.pump(const Duration(seconds: 4));
    await expectLater(
      find.byType(CharadesApp),
      matchesGoldenFile('goldens/2_game.png'),
    );

    await tester.tap(find.byTooltip('End round'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End round'));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(CharadesApp),
      matchesGoldenFile('goldens/3_summary.png'),
    );
  });
}
