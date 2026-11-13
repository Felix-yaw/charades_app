import 'package:charades_app/data/word_repository.dart';
import 'package:charades_app/viewmodels/game_view_model.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_motion_service.dart';

void main() {
  test('daily deck is five words, deterministic per day, fresh next day', () {
    final WordRepository repository = WordRepository();
    final List<String> today = repository
        .dailyDeck(DateTime(2026, 11, 13))
        .map((wordCard) => wordCard.text)
        .toList();
    final List<String> sameDay = repository
        .dailyDeck(DateTime(2026, 11, 13, 23, 59))
        .map((wordCard) => wordCard.text)
        .toList();
    final List<String> nextDay = repository
        .dailyDeck(DateTime(2026, 11, 14))
        .map((wordCard) => wordCard.text)
        .toList();

    expect(today.length, 5);
    expect(today, sameDay);
    expect(today, isNot(nextDay));
  });

  test('reverse mode swaps tilt up and tilt down', () {
    fakeAsync((FakeAsync fakeClock) {
      final FakeMotionService motionService = FakeMotionService();
      final GameViewModel gameViewModel =
          GameViewModel(motionService: motionService);
      gameViewModel.setReverseGestures(true);
      gameViewModel.startRound();
      fakeClock.elapse(const Duration(seconds: 3));

      final DateTime base = DateTime(2026, 1, 1);
      motionService.emitTilt(0, base);
      motionService.emitTilt(0.6, base.add(const Duration(milliseconds: 200)));
      expect(gameViewModel.passedWords.length, 1);
      expect(gameViewModel.score, 0);

      motionService.emitTilt(0, base.add(const Duration(milliseconds: 800)));
      motionService.emitTilt(-0.6, base.add(const Duration(milliseconds: 1000)));
      expect(gameViewModel.score, 1);

      gameViewModel.dispose();
    });
  });

  test('daily challenge round uses the seeded deck and ends after five words', () {
    fakeAsync((FakeAsync fakeClock) {
      final GameViewModel gameViewModel =
          GameViewModel(motionService: FakeMotionService());
      gameViewModel.startDailyChallenge();
      fakeClock.elapse(const Duration(seconds: 3));

      for (int index = 0; index < 5; index++) {
        gameViewModel.markGuessed();
      }
      expect(gameViewModel.score, 5);
      expect(gameViewModel.phase, GamePhase.roundOver);

      gameViewModel.dispose();
    });
  });
}
