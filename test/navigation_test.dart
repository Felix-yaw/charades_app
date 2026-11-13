import 'package:charades_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('bottom nav switches between custom words, packs and history',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    expect(find.text('SUPER MIX'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Custom words'));
    expect(find.text('My Words'), findsOneWidget);
    expect(find.text('No custom words yet. Add some to build your own pack.'),
        findsOneWidget);
    expect(find.text('SUPER MIX'), findsNothing);

    await tapVisible(tester, find.byTooltip('History'));
    expect(find.text('History'), findsOneWidget);
    expect(find.text('No rounds yet. Play a round and it will show up here.'),
        findsOneWidget);

    await tapVisible(tester, find.byTooltip('Packs'));
    expect(find.text('SUPER MIX'), findsOneWidget);
  });

  testWidgets('custom words feed the My Words pack on the packs tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.byTooltip('Custom words'));
    await tester.enterText(find.byType(TextField), '  Unicorn  ');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Unicorn'), findsOneWidget);
    expect(find.text('1 word in your pack'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Packs'));
    expect(find.text('My Words'), findsOneWidget);

    await tapVisible(tester, find.text('My Words'));
    await tester.pump(const Duration(seconds: 4));

    expect(find.text('Got it'), findsOneWidget);
    expect(find.text('Unicorn'), findsOneWidget);
  });

  testWidgets('Play My Words button starts a round with the custom pack',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.byTooltip('Custom words'));
    expect(find.text('Play My Words'), findsNothing);

    await tester.enterText(find.byType(TextField), 'Dragon');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Play My Words'));
    await tester.pump(const Duration(seconds: 4));

    expect(find.text('Got it'), findsOneWidget);
    expect(find.text('Dragon'), findsOneWidget);
    expect(find.text('MY WORDS'), findsOneWidget);
  });

  testWidgets('finished rounds appear on the history tab',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 4));
    await tester.tap(find.byTooltip('End round'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End round'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Change settings'));

    await tapVisible(tester, find.byTooltip('History'));
    expect(find.text('Animals'), findsOneWidget);
    expect(find.text('Score: 0'), findsOneWidget);
  });
}
