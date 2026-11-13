import 'package:charades_app/data/offline/custom_words_store.dart';
import 'package:charades_app/data/offline/round_history_store.dart';
import 'package:charades_app/models/round_record.dart';
import 'package:charades_app/models/word_card.dart';
import 'package:charades_app/viewmodels/game_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fake_motion_service.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  test('restore loads persisted custom words and history', () async {
    await CustomWordsStore().save(['Unicorn', 'Dragon']);
    await RoundHistoryStore().save([
      RoundRecord(
        category: WordCategory.food,
        score: 3,
        guessedCount: 3,
        passedCount: 1,
        playedAt: DateTime(2026, 1, 1, 10, 30),
      ),
    ]);

    final GameViewModel gameViewModel =
        GameViewModel(motionService: FakeMotionService());
    await gameViewModel.restorePersistedState();

    expect(
      gameViewModel.customWords.map((wordCard) => wordCard.text),
      ['Unicorn', 'Dragon'],
    );
    expect(gameViewModel.history.single.score, 3);
    expect(gameViewModel.history.single.category, WordCategory.food);
    expect(gameViewModel.history.single.guessedCount, 3);
    expect(gameViewModel.history.single.passedCount, 1);

    gameViewModel.dispose();
  });

  test('addCustomWord and removeCustomWord persist to storage', () async {
    final GameViewModel gameViewModel =
        GameViewModel(motionService: FakeMotionService());

    gameViewModel.addCustomWord('Unicorn');
    await pumpEventQueue();
    expect(await CustomWordsStore().load(), ['Unicorn']);

    gameViewModel.removeCustomWord('Unicorn');
    await pumpEventQueue();
    expect(await CustomWordsStore().load(), isEmpty);

    gameViewModel.dispose();
  });

  test('finished rounds persist to history storage', () async {
    final GameViewModel gameViewModel =
        GameViewModel(motionService: FakeMotionService());

    gameViewModel.startRoundWithCategory(WordCategory.animals);
    gameViewModel.endRoundEarly();
    await pumpEventQueue();

    final List<RoundRecord> records = await RoundHistoryStore().load();
    expect(records.single.category, WordCategory.animals);
    expect(records.single.playedAt, isNotNull);

    gameViewModel.dispose();
  });

  test('restore never clobbers in-session words', () async {
    final GameViewModel gameViewModel =
        GameViewModel(motionService: FakeMotionService());

    gameViewModel.addCustomWord('Unicorn');
    await gameViewModel.restorePersistedState();

    expect(
      gameViewModel.customWords.map((wordCard) => wordCard.text),
      ['Unicorn'],
    );

    gameViewModel.dispose();
  });
}
