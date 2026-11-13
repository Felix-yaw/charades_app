import 'package:charades_app/data/word_repository.dart';
import 'package:charades_app/models/word_card.dart';
import 'package:charades_app/viewmodels/game_view_model.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_motion_service.dart';

void main() {
  group('GameViewModel motion controls', () {
    final DateTime base = DateTime(2026, 1, 1);

    test('tilt up scores a point and tilt down passes', () {
      fakeAsync((FakeAsync fakeClock) {
        final FakeMotionService motionService = FakeMotionService();
        final GameViewModel gameViewModel =
            GameViewModel(motionService: motionService);
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        final WordCard firstCard = gameViewModel.currentCard!;
        motionService.emitTilt(0, base);
        motionService.emitTilt(0.6, base.add(const Duration(milliseconds: 200)));

        expect(gameViewModel.score, 1);
        expect(gameViewModel.guessedWords.single, firstCard);

        motionService.emitTilt(0, base.add(const Duration(milliseconds: 800)));
        motionService.emitTilt(
            -0.6, base.add(const Duration(milliseconds: 1000)));

        expect(gameViewModel.score, 1);
        expect(gameViewModel.passedWords.length, 1);

        gameViewModel.dispose();
      });
    });

    test('tilt samples are ignored while motion controls are disabled', () {
      fakeAsync((FakeAsync fakeClock) {
        final FakeMotionService motionService = FakeMotionService();
        final GameViewModel gameViewModel =
            GameViewModel(motionService: motionService);
        gameViewModel.setMotionControlsEnabled(false);
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        motionService.emitTilt(0, base);
        motionService.emitTilt(0.6, base.add(const Duration(milliseconds: 200)));

        expect(gameViewModel.score, 0);
        expect(gameViewModel.passedWords, isEmpty);

        gameViewModel.dispose();
      });
    });

    test('tilt samples are ignored during the countdown and after the round', () {
      fakeAsync((FakeAsync fakeClock) {
        final FakeMotionService motionService = FakeMotionService();
        final GameViewModel gameViewModel =
            GameViewModel(motionService: motionService);
        gameViewModel.startRound();

        motionService.emitTilt(0, base);
        motionService.emitTilt(0.6, base.add(const Duration(milliseconds: 200)));
        expect(gameViewModel.score, 0);

        fakeClock.elapse(const Duration(seconds: 3));
        gameViewModel.endRoundEarly();

        motionService.emitTilt(1.0, base.add(const Duration(milliseconds: 600)));
        expect(gameViewModel.score, 0);
        expect(gameViewModel.passedWords, isEmpty);

        gameViewModel.dispose();
      });
    });

    test('a tilt pass reaches the round summary when the deck empties', () {
      fakeAsync((FakeAsync fakeClock) {
        final FakeMotionService motionService = FakeMotionService();
        final GameViewModel gameViewModel = GameViewModel(
          motionService: motionService,
          wordRepository: WordRepository(words: const [
            WordCard('Alpha', WordCategory.animals),
            WordCard('Beta', WordCategory.animals),
          ]),
        );
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        motionService.emitTilt(0, base);
        motionService.emitTilt(-0.6, base.add(const Duration(milliseconds: 200)));
        motionService.emitTilt(0, base.add(const Duration(milliseconds: 800)));
        motionService.emitTilt(-0.6, base.add(const Duration(milliseconds: 1000)));

        expect(gameViewModel.passedWords.length, 2);
        expect(gameViewModel.phase, GamePhase.roundOver);

        gameViewModel.dispose();
      });
    });
  });
}
