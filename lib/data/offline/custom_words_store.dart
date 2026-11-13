import 'package:shared_preferences/shared_preferences.dart';

class CustomWordsStore {
  CustomWordsStore({SharedPreferences? preferences})
      : _preferencesOverride = preferences;

  static const String _key = 'custom_words';

  final SharedPreferences? _preferencesOverride;

  Future<List<String>> load() async {
    final SharedPreferences preferences = await _resolve();
    return preferences.getStringList(_key) ?? const [];
  }

  Future<void> save(List<String> words) async {
    final SharedPreferences preferences = await _resolve();
    await preferences.setStringList(_key, words);
  }

  Future<SharedPreferences> _resolve() async {
    return _preferencesOverride ?? await SharedPreferences.getInstance();
  }
}
