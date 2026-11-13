import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/utils/tilt_angle.dart';
import '../data/offline/custom_words_store.dart';
import '../data/offline/round_history_store.dart';
import '../data/services/motion_service.dart';
import '../data/word_repository.dart';
import '../models/accelerometer_sample.dart';
import '../models/round_record.dart';
import '../models/word_card.dart';
import 'tilt_gesture_detector.dart';

enum GamePhase { setup, countdown, playing, roundOver }

class GameViewModel extends ChangeNotifier {
  GameViewModel({
    WordRepository? wordRepository,
    MotionService? motionService,
    CustomWordsStore? customWordsStore,
    RoundHistoryStore? historyStore,
  })  : _wordRepository = wordRepository ?? WordRepository(),
        _motionService = motionService ?? DeviceMotionService(),
        _customWordsStore = customWordsStore ?? CustomWordsStore(),
        _historyStore = historyStore ?? RoundHistoryStore();

  static const List<int> roundDurationOptions = [30, 60, 90];
  static const int getReadySeconds = 3;

  final WordRepository _wordRepository;
  final MotionService _motionService;
  final CustomWordsStore _customWordsStore;
  final RoundHistoryStore _historyStore;
  final TiltGestureDetector _tiltDetector = TiltGestureDetector();

  GamePhase _phase = GamePhase.setup;
  WordCategory _selectedCategory = WordCategory.all;
  int _roundSeconds = 60;
  int _countdownValue = getReadySeconds;
  int _remainingSeconds = 60;
  List<WordCard> _deck = const [];
  WordCard? _currentCard;
  List<WordCard> _guessedWords = const [];
  List<WordCard> _passedWords = const [];
  List<WordCard> _customWords = const [];
  List<RoundRecord> _history = const [];
  Timer? _ticker;
  StreamSubscription<AccelerometerSample>? _tiltSubscription;
  bool _motionControlsEnabled = true;

  GamePhase get phase => _phase;
  WordCategory get selectedCategory => _selectedCategory;
  int get roundSeconds => _roundSeconds;
  int get countdownValue => _countdownValue;
  int get remainingSeconds => _remainingSeconds;
  WordCard? get currentCard => _currentCard;

  // Copy-on-append keeps identity stable so Selector slices only rebuild when
  // the content actually changes.
  List<WordCard> get guessedWords => _guessedWords;
  List<WordCard> get passedWords => _passedWords;
  List<WordCard> get customWords => _customWords;
  List<RoundRecord> get history => _history;
  int get totalScore =>
      _history.fold(0, (sum, record) => sum + record.score);
  int get roundsPlayed => _history.length;
  int get bestScore => _history.fold(
      0, (best, record) => record.score > best ? record.score : best);
  int get score => _guessedWords.length;
  bool get isRoundActive => _phase == GamePhase.playing;
  bool get motionControlsEnabled => _motionControlsEnabled;

  void setMotionControlsEnabled(bool enabled) {
    if (enabled == _motionControlsEnabled) return;
    _motionControlsEnabled = enabled;
    _syncTiltSubscription();
    notifyListeners();
  }

  void addCustomWord(String text) {
    final String word = text.trim();
    if (word.isEmpty) return;
    if (_customWords
        .any((wordCard) => wordCard.text.toLowerCase() == word.toLowerCase())) {
      return;
    }
    _customWords = [
      ..._customWords,
      WordCard(word, WordCategory.custom),
    ];
    _persistCustomWords();
    notifyListeners();
  }

  void removeCustomWord(String text) {
    final int before = _customWords.length;
    _customWords = _customWords
        .where((wordCard) => wordCard.text != text)
        .toList(growable: false);
    if (_customWords.length == before) return;
    _persistCustomWords();
    notifyListeners();
  }

  Future<void> restorePersistedState() async {
    if (_customWords.isNotEmpty || _history.isNotEmpty) return;
    List<String> words;
    List<RoundRecord> records;
    try {
      words = await _customWordsStore.load();
      records = await _historyStore.load();
    } catch (_) {
      return;
    }
    if (_customWords.isNotEmpty || _history.isNotEmpty) return;
    _customWords = [
      for (final String word in words) WordCard(word, WordCategory.custom),
    ];
    _history = records;
    notifyListeners();
  }

  // Word lists and stats are best-effort local data: a failed write must not
  // interrupt gameplay, so persistence errors are dropped here.
  Future<void> _persistCustomWords() async {
    try {
      await _customWordsStore
          .save([for (final WordCard wordCard in _customWords) wordCard.text]);
    } catch (_) {}
  }

  Future<void> _persistHistory() async {
    try {
      await _historyStore.save(_history);
    } catch (_) {}
  }

  void selectCategory(WordCategory category) {
    if (category == _selectedCategory) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void selectRoundSeconds(int seconds) {
    if (seconds == _roundSeconds) return;
    _roundSeconds = seconds;
    notifyListeners();
  }

  void startRound() {
    _ticker?.cancel();
    _deck = _wordRepository.shuffledDeck(
      _selectedCategory,
      customWords: _customWords,
    );
    _guessedWords = const [];
    _passedWords = const [];
    _currentCard = null;
    _countdownValue = getReadySeconds;
    _remainingSeconds = _roundSeconds;
    _phase = GamePhase.countdown;
    _tiltDetector.reset();
    _syncTiltSubscription();
    notifyListeners();
    _ticker = Timer.periodic(const Duration(seconds: 1), _onTick);
  }

  void startRoundWithCategory(WordCategory category) {
    if (category == WordCategory.custom && _customWords.isEmpty) return;
    _selectedCategory = category;
    startRound();
  }

  void markGuessed() {
    if (_phase != GamePhase.playing || _currentCard == null) return;
    _guessedWords = [..._guessedWords, _currentCard!];
    _advance();
    notifyListeners();
  }

  void pass() {
    if (_phase != GamePhase.playing || _currentCard == null) return;
    _passedWords = [..._passedWords, _currentCard!];
    _advance();
    notifyListeners();
  }

  void endRoundEarly() {
    if (_phase != GamePhase.countdown && _phase != GamePhase.playing) return;
    _finishRound();
  }

  void playAgain() => startRound();

  void backToSetup() {
    _stopTicker();
    _phase = GamePhase.setup;
    _syncTiltSubscription();
    notifyListeners();
  }

  void _onTick(Timer timer) {
    if (_phase == GamePhase.countdown) {
      _countdownValue -= 1;
      if (_countdownValue <= 0) {
        _countdownValue = 0;
        _phase = GamePhase.playing;
        _advance();
        _syncTiltSubscription();
      }
      notifyListeners();
      return;
    }
    if (_phase == GamePhase.playing) {
      _remainingSeconds -= 1;
      if (_remainingSeconds <= 0) {
        _remainingSeconds = 0;
        _finishRound();
        return;
      }
      notifyListeners();
    }
  }

  void _advance() {
    if (_deck.isEmpty) {
      _currentCard = null;
      _finishRound();
      return;
    }
    _currentCard = _deck.first;
    _deck = _deck.sublist(1);
  }

  void _finishRound() {
    _stopTicker();
    _currentCard = null;
    _phase = GamePhase.roundOver;
    _history = [
      RoundRecord(
        category: _selectedCategory,
        score: _guessedWords.length,
        guessedCount: _guessedWords.length,
        passedCount: _passedWords.length,
        playedAt: DateTime.now(),
      ),
      ..._history,
    ];
    _persistHistory();
    _syncTiltSubscription();
    notifyListeners();
  }

  void _syncTiltSubscription() {
    final bool shouldListen =
        _motionControlsEnabled && _phase == GamePhase.playing;
    if (shouldListen && _tiltSubscription == null) {
      _tiltSubscription = _motionService.samples.listen(_onTiltSample);
    } else if (!shouldListen) {
      _tiltSubscription?.cancel();
      _tiltSubscription = null;
    }
  }

  void _onTiltSample(AccelerometerSample sample) {
    if (_phase != GamePhase.playing) return;
    final double angle = tiltAngleFromAccelerometer(sample.y, sample.z);
    final TiltDirection? direction =
        _tiltDetector.processSample(angle, sample.timestamp);
    if (direction == TiltDirection.up) {
      markGuessed();
    } else if (direction == TiltDirection.down) {
      pass();
    }
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  @override
  void dispose() {
    _tiltSubscription?.cancel();
    _stopTicker();
    super.dispose();
  }
}
