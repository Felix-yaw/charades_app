import 'package:charades_app/data/word_repository.dart';
import 'package:charades_app/models/word_card.dart';
import 'package:charades_app/viewmodels/game_view_model.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_motion_service.dart';

void main() {
  group('GameViewModel', () {
    test('startRound counts down, then plays with a dealt card', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());

        gameViewModel.startRound();
        expect(gameViewModel.phase, GamePhase.countdown);
        expect(gameViewModel.countdownValue, GameViewModel.getReadySeconds);

        fakeClock.elapse(const Duration(seconds: 3));

        expect(gameViewModel.phase, GamePhase.playing);
        expect(gameViewModel.currentCard, isNotNull);
        expect(gameViewModel.remainingSeconds, 60);

        gameViewModel.dispose();
      });
    });

    test('markGuessed scores a point and deals the next card', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        final WordCard firstCard = gameViewModel.currentCard!;
        gameViewModel.markGuessed();

        expect(gameViewModel.score, 1);
        expect(gameViewModel.guessedWords, [firstCard]);
        expect(gameViewModel.currentCard, isNotNull);
        expect(gameViewModel.currentCard, isNot(firstCard));

        gameViewModel.dispose();
      });
    });

    test('pass records the card without scoring', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        final WordCard firstCard = gameViewModel.currentCard!;
        gameViewModel.pass();

        expect(gameViewModel.score, 0);
        expect(gameViewModel.passedWords, [firstCard]);
        expect(gameViewModel.currentCard, isNotNull);

        gameViewModel.dispose();
      });
    });

    test('round ends when the timer runs out', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        fakeClock.elapse(const Duration(seconds: 61));

        expect(gameViewModel.remainingSeconds, 0);
        expect(gameViewModel.phase, GamePhase.roundOver);
        expect(gameViewModel.currentCard, isNull);

        gameViewModel.dispose();
      });
    });

    test('round ends early when the deck runs out', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel = GameViewModel(
          motionService: FakeMotionService(),
          wordRepository: WordRepository(words: const [
            WordCard('Alpha', WordCategory.animals),
            WordCard('Beta', WordCategory.animals),
          ]),
        );
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        gameViewModel.markGuessed();
        gameViewModel.markGuessed();

        expect(gameViewModel.score, 2);
        expect(gameViewModel.phase, GamePhase.roundOver);

        gameViewModel.dispose();
      });
    });

    test('endRoundEarly finishes an active round', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));

        gameViewModel.endRoundEarly();
        expect(gameViewModel.phase, GamePhase.roundOver);

        gameViewModel.endRoundEarly();
        expect(gameViewModel.phase, GamePhase.roundOver);

        gameViewModel.dispose();
      });
    });

    test('playAgain starts a fresh round with the same settings', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.selectRoundSeconds(30);
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));
        gameViewModel.markGuessed();
        gameViewModel.endRoundEarly();

        gameViewModel.playAgain();

        expect(gameViewModel.phase, GamePhase.countdown);
        expect(gameViewModel.score, 0);
        expect(gameViewModel.remainingSeconds, 30);

        gameViewModel.dispose();
      });
    });

    test('backToSetup returns to the setup phase', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.startRound();
        fakeClock.elapse(const Duration(seconds: 3));
        gameViewModel.endRoundEarly();

        gameViewModel.backToSetup();

        expect(gameViewModel.phase, GamePhase.setup);

        gameViewModel.dispose();
      });
    });

    test('settings setters notify only on real changes', () {
      final GameViewModel gameViewModel =
          GameViewModel(motionService: FakeMotionService());
      int notifications = 0;
      gameViewModel.addListener(() => notifications += 1);

      gameViewModel.selectCategory(WordCategory.all);
      gameViewModel.selectRoundSeconds(60);
      expect(notifications, 0);

      gameViewModel.selectCategory(WordCategory.movies);
      gameViewModel.selectRoundSeconds(90);
      expect(notifications, 2);
      expect(gameViewModel.selectedCategory, WordCategory.movies);
      expect(gameViewModel.roundSeconds, 90);

      gameViewModel.dispose();
    });

    test('gameplay actions are no-ops outside the playing phase', () {
      final GameViewModel gameViewModel =
          GameViewModel(motionService: FakeMotionService());
      int notifications = 0;
      gameViewModel.addListener(() => notifications += 1);

      gameViewModel.markGuessed();
      gameViewModel.pass();
      expect(notifications, 0);
      expect(gameViewModel.score, 0);

      gameViewModel.dispose();
    });
  });
}
