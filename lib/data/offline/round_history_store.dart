import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/round_record.dart';
import '../../models/word_card.dart';

class RoundHistoryStore {
  RoundHistoryStore({SharedPreferences? preferences})
      : _preferencesOverride = preferences;

  static const String _key = 'round_history';

  final SharedPreferences? _preferencesOverride;

  Future<List<RoundRecord>> load() async {
    final SharedPreferences preferences = await _resolve();
    final List<String> raw =
        preferences.getStringList(_key) ?? const <String>[];
    return raw
        .map(_decode)
        .whereType<RoundRecord>()
        .toList(growable: false);
  }

  Future<void> save(List<RoundRecord> records) async {
    final SharedPreferences preferences = await _resolve();
    await preferences.setStringList(
      _key,
      records.map(_encode).toList(growable: false),
    );
  }

  Future<SharedPreferences> _resolve() async {
    return _preferencesOverride ?? await SharedPreferences.getInstance();
  }

  String _encode(RoundRecord record) {
    return jsonEncode({
      'category': record.category.name,
      'score': record.score,
      'guessed': record.guessedCount,
      'passed': record.passedCount,
      'playedAt': record.playedAt.millisecondsSinceEpoch,
    });
  }

  RoundRecord? _decode(String raw) {
    try {
      final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
      final String categoryName = json['category'] as String;
      final WordCategory? category = WordCategory.values
          .where((value) => value.name == categoryName)
          .firstOrNull;
      if (category == null) return null;
      return RoundRecord(
        category: category,
        score: json['score'] as int,
        guessedCount: json['guessed'] as int,
        passedCount: json['passed'] as int,
        playedAt: DateTime.fromMillisecondsSinceEpoch(json['playedAt'] as int),
      );
    } catch (_) {
      return null;
    }
  }
}
