import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../models/level.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';
import 'scoring_engine.dart';
import 'word_validator.dart';

class TimedChallengeEngine extends ChangeNotifier {
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final StorageService storageService;

  Level? _puzzleLevel;
  List<String> _letters = [];
  List<int> _selectedIndices = [];
  final Set<String> _foundWords = {};
  int _score = 0;
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _isPlaying = false;
  bool _isGameOver = false;

  TimedChallengeEngine({
    required this.levelRepository,
    required this.wordRepository,
    required this.storageService,
  });

  PlayerProgress get progress => storageService.progress;
  Level? get puzzleLevel => _puzzleLevel;
  List<String> get letters => _letters;
  List<int> get selectedIndices => _selectedIndices;
  Set<String> get foundWords => _foundWords;
  int get score => _score;
  int get secondsRemaining => _secondsRemaining;
  bool get isPlaying => _isPlaying;
  bool get isGameOver => _isGameOver;

  String get currentWord => _selectedIndices.map((i) => _letters[i]).join();

  void startChallenge() {
    _timer?.cancel();
    // Pick a random level from class 2, 3 or 4
    final random = Random();
    final candidateLevels = levelRepository.levels
        .where((l) => l.letters.length >= 4 && l.validAnswers.length >= 4)
        .toList();
    _puzzleLevel = candidateLevels.isNotEmpty
        ? candidateLevels[random.nextInt(candidateLevels.length)]
        : levelRepository.levels.first;

    _letters = List.from(_puzzleLevel!.letters)..shuffle(random);
    _selectedIndices = [];
    _foundWords.clear();
    _score = 0;
    _secondsRemaining = 60;
    _isPlaying = true;
    _isGameOver = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _endChallenge();
      }
    });

    notifyListeners();
  }

  void selectLetterAt(int index) {
    if (!_isPlaying) return;
    if (_selectedIndices.contains(index)) {
      _selectedIndices.remove(index);
    } else {
      _selectedIndices.add(index);
    }
    AudioService.playTileTap();
    notifyListeners();
  }

  void removeLast() {
    if (_selectedIndices.isNotEmpty) {
      _selectedIndices.removeLast();
      AudioService.playTileTap();
      notifyListeners();
    }
  }

  void clear() {
    if (_selectedIndices.isNotEmpty) {
      _selectedIndices.clear();
      AudioService.playTileTap();
      notifyListeners();
    }
  }

  void shuffle() {
    _letters.shuffle();
    _selectedIndices.clear();
    AudioService.playTileTap();
    notifyListeners();
  }

  bool submitWord() {
    if (!_isPlaying || _puzzleLevel == null) return false;
    final word = currentWord;
    final res = WordValidator.validate(
      submittedWord: word,
      level: _puzzleLevel!,
      alreadyFoundWords: _foundWords,
    );

    if (res.isValid) {
      final upper = word.toUpperCase();
      _foundWords.add(upper);
      final pts =
          ScoringEngine.getWordScore(upper) * 2; // Double points in timed rush!
      _score += pts;
      AudioService.playWordSuccess();
      _selectedIndices.clear();
      notifyListeners();
      return true;
    } else {
      AudioService.playWordError();
      _selectedIndices.clear();
      notifyListeners();
      return false;
    }
  }

  void _endChallenge() {
    _timer?.cancel();
    _isPlaying = false;
    _isGameOver = true;

    // Check high score
    if (_score > progress.timedHighScore) {
      progress.timedHighScore = _score;
    }
    // Earn coins proportional to score
    final earnedCoins = (_score / 5).round();
    progress.coins += earnedCoins;
    storageService.saveProgress(progress);

    AudioService.playLevelComplete();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
