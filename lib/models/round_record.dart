import 'word_card.dart';

class RoundRecord {
  const RoundRecord({
    required this.category,
    required this.score,
    required this.guessedCount,
    required this.passedCount,
    required this.playedAt,
  });

  final WordCategory category;
  final int score;
  final int guessedCount;
  final int passedCount;
  final DateTime playedAt;
}
