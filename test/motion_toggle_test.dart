import 'package:charades_app/main.dart';
import 'package:charades_app/view/screens/game_screen.dart';
import 'package:charades_app/view/screens/home_shell_screen.dart';
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

const String tiltHintText = 'Tilt up: Got it  ·  Tilt down: Pass';

void main() {
  testWidgets('tilt controls toggle updates the setting', (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.byTooltip('Settings'));
    expect(find.text('Tilt controls'), findsOneWidget);

    final BuildContext setupContext = tester.element(find.byType(HomeShellScreen));
    final GameViewModel gameViewModel =
        Provider.of<GameViewModel>(setupContext, listen: false);
    expect(gameViewModel.motionControlsEnabled, isTrue);

    await tapVisible(tester, find.byType(Switch));
    await tester.pump();
    expect(gameViewModel.motionControlsEnabled, isFalse);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(gameViewModel.motionControlsEnabled, isTrue);

    await tapVisible(tester, find.text('Done'));
    expect(find.text('Tilt controls'), findsNothing);
  });

  testWidgets('tilt hint is shown in-round while motion controls are on',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 4));

    final BuildContext gameContext = tester.element(find.byType(GameScreen));
    expect(
      Provider.of<GameViewModel>(gameContext, listen: false).motionControlsEnabled,
      isTrue,
    );
    expect(find.text(tiltHintText), findsOneWidget);
  });

  testWidgets('tilt hint is hidden when motion controls are off',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CharadesApp());

    await tapVisible(tester, find.byTooltip('Settings'));
    await tapVisible(tester, find.byType(Switch));
    await tester.pump();
    await tapVisible(tester, find.text('Done'));

    await tapVisible(tester, find.text('Animals'));
    await tester.pump(const Duration(seconds: 4));

    expect(find.byType(GameScreen), findsOneWidget);
    expect(find.text(tiltHintText), findsNothing);
  });
}
