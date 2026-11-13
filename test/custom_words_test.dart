import 'package:charades_app/data/word_repository.dart';
import 'package:charades_app/models/word_card.dart';
import 'package:charades_app/viewmodels/game_view_model.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_motion_service.dart';

void main() {
  group('custom words', () {
    test('addCustomWord trims input and ignores empty or duplicate words', () {
      final GameViewModel gameViewModel =
          GameViewModel(motionService: FakeMotionService());

      gameViewModel.addCustomWord('   ');
      gameViewModel.addCustomWord('  Unicorn  ');
      gameViewModel.addCustomWord('unicorn');
      gameViewModel.addCustomWord('Dragon');

      expect(
        gameViewModel.customWords.map((wordCard) => wordCard.text),
        ['Unicorn', 'Dragon'],
      );

      gameViewModel.dispose();
    });

    test('removeCustomWord removes by exact text', () {
      final GameViewModel gameViewModel =
          GameViewModel(motionService: FakeMotionService());
      gameViewModel.addCustomWord('Unicorn');
      gameViewModel.addCustomWord('Dragon');

      gameViewModel.removeCustomWord('Unicorn');
      gameViewModel.removeCustomWord('Missing');

      expect(
        gameViewModel.customWords.map((wordCard) => wordCard.text),
        ['Dragon'],
      );

      gameViewModel.dispose();
    });

    test('My Words round cannot start with an empty custom pack', () {
      final GameViewModel gameViewModel =
          GameViewModel(motionService: FakeMotionService());

      gameViewModel.startRoundWithCategory(WordCategory.custom);

      expect(gameViewModel.phase, GamePhase.setup);

      gameViewModel.dispose();
    });

    test('My Words round deals only custom words and ends on exhaustion', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());
        gameViewModel.addCustomWord('Unicorn');
        gameViewModel.addCustomWord('Dragon');

        gameViewModel.startRoundWithCategory(WordCategory.custom);
        fakeClock.elapse(const Duration(seconds: 3));

        expect(gameViewModel.phase, GamePhase.playing);
        gameViewModel.markGuessed();
        gameViewModel.markGuessed();

        expect(gameViewModel.score, 2);
        expect(gameViewModel.phase, GamePhase.roundOver);

        gameViewModel.dispose();
      });
    });

    test('custom words are included in the Super Mix deck', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel = GameViewModel(
          motionService: FakeMotionService(),
          wordRepository: WordRepository(words: const [
            WordCard('Alpha', WordCategory.animals),
          ]),
        );
        gameViewModel.addCustomWord('Unicorn');

        gameViewModel.startRoundWithCategory(WordCategory.all);
        fakeClock.elapse(const Duration(seconds: 3));
        gameViewModel.markGuessed();
        gameViewModel.markGuessed();

        expect(gameViewModel.score, 2);
        expect(gameViewModel.phase, GamePhase.roundOver);

        gameViewModel.dispose();
      });
    });
  });

  group('history', () {
    test('finished rounds are recorded newest first', () {
      fakeAsync((FakeAsync fakeClock) {
        final GameViewModel gameViewModel =
            GameViewModel(motionService: FakeMotionService());

        gameViewModel.startRoundWithCategory(WordCategory.animals);
        fakeClock.elapse(const Duration(seconds: 3));
        gameViewModel.markGuessed();
        gameViewModel.endRoundEarly();

        gameViewModel.startRoundWithCategory(WordCategory.food);
        fakeClock.elapse(const Duration(seconds: 3));
        gameViewModel.endRoundEarly();

        expect(gameViewModel.history.length, 2);
        expect(gameViewModel.history.first.category, WordCategory.food);
        expect(gameViewModel.history.first.score, 0);
        expect(gameViewModel.history.last.category, WordCategory.animals);
        expect(gameViewModel.history.last.score, 1);

        gameViewModel.dispose();
      });
    });
  });
}
