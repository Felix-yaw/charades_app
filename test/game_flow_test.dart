import 'package:charades_app/main.dart';
import 'package:charades_app/models/word_card.dart';
import 'package:charades_app/view/screens/game_screen.dart';
import 'package:charades_app/viewmodels/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('home to countdown to playing to summary', (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    expect(find.text('@charades'), findsOneWidget);
    expect(find.text('SUPER MIX'), findsOneWidget);

    await tapVisible(tester, find.text('Animals'));
    await tester.pump();

    expect(find.text('Get ready!'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Got it'), findsOneWidget);
    expect(find.text('Pass'), findsOneWidget);
    expect(find.text('Score: 0'), findsOneWidget);

    final BuildContext gameContext = tester.element(find.byType(GameScreen));
    final GameViewModel gameViewModel =
        Provider.of<GameViewModel>(gameContext, listen: false);
    final String firstWord = gameViewModel.currentCard!.text;
    expect(find.text(firstWord), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Score: 1'), findsOneWidget);
    expect(find.text(firstWord), findsNothing);

    await tester.tap(find.byTooltip('End round'));
    await tester.pumpAndSettle();

    expect(find.text('End round?'), findsOneWidget);
    await tester.tap(find.text('End round'));
    await tester.pumpAndSettle();

    expect(find.text('Round over!'), findsOneWidget);
    expect(find.text('Score: 1'), findsOneWidget);
    expect(find.text('Guessed (1)'), findsOneWidget);
    expect(find.text(firstWord), findsOneWidget);
  });

  testWidgets('pass records a pass without scoring', (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 3));

    final BuildContext gameContext = tester.element(find.byType(GameScreen));
    final GameViewModel gameViewModel =
        Provider.of<GameViewModel>(gameContext, listen: false);
    final String firstWord = gameViewModel.currentCard!.text;

    await tester.tap(find.text('Pass'));
    await tester.pump();

    expect(gameViewModel.score, 0);
    expect(gameViewModel.passedWords.single.text, firstWord);
    expect(gameViewModel.selectedCategory, WordCategory.animals);
  });

  testWidgets('round ends when the timer runs out', (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.text('SUPER MIX'));
    await tester.pump(const Duration(seconds: 64));

    expect(find.text('Round over!'), findsOneWidget);
    expect(find.text('Score: 0'), findsOneWidget);
  });

  testWidgets('summary buttons lead back to home or a new round',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 4));

    await tester.tap(find.byTooltip('End round'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End round'));
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Change settings'));
    await tester.pump();
    expect(find.text('@charades'), findsOneWidget);

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 4));
    await tester.tap(find.byTooltip('End round'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('End round'));
    await tester.pumpAndSettle();

    await tapVisible(tester, find.text('Play again'));
    await tester.pump();
    expect(find.text('Get ready!'), findsOneWidget);
  });

  testWidgets('cancelling the end-round dialog keeps the round going',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 4));

    await tester.tap(find.byTooltip('End round'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Keep playing'));
    await tester.pumpAndSettle();

    expect(find.text('Got it'), findsOneWidget);
    expect(find.text('End round?'), findsNothing);
  });
}
