import 'dart:math';
import 'package:flutter/foundation.dart';
import '../data/achievement_repository.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../models/achievement.dart';
import '../models/level.dart';
import '../models/player_progress.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';
import 'hint_system.dart';
import 'scoring_engine.dart';
import 'word_validator.dart';

class GameEngine extends ChangeNotifier {
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final AchievementRepository achievementRepository;
  final StorageService storageService;

  Level? _currentLevel;
  List<String> _displayLetters = [];
  List<int> _selectedIndices = []; // indices into _displayLetters
  final Set<String> _foundWords = {};
  int _sessionScore = 0;
  String _statusFeedback = '';
  String _statusFeedbackUrdu = '';
  bool _isLastActionSuccess = false;
  Achievement? _recentlyUnlockedAchievement;

  GameEngine({
    required this.levelRepository,
    required this.wordRepository,
    required this.achievementRepository,
    required this.storageService,
  });

  PlayerProgress get progress => storageService.progress;
  Level? get currentLevel => _currentLevel;
  List<String> get displayLetters => List.unmodifiable(_displayLetters);
  List<int> get selectedIndices => List.unmodifiable(_selectedIndices);
  Set<String> get foundWords => Set.unmodifiable(_foundWords);
  int get sessionScore => _sessionScore;
  String get statusFeedback => _statusFeedback;
  String get statusFeedbackUrdu => _statusFeedbackUrdu;
  bool get isLastActionSuccess => _isLastActionSuccess;
  Achievement? get recentlyUnlockedAchievement => _recentlyUnlockedAchievement;

  String get currentWord {
    return _selectedIndices.map((i) => _displayLetters[i]).join();
  }

  bool get isLevelCompleted {
    if (_currentLevel == null) return false;
    return _foundWords.length >= _currentLevel!.targetWords;
  }

  void startLevel(Level level) {
    _currentLevel = level;
    _displayLetters = List.from(level.letters);
    _selectedIndices = [];
    _foundWords.clear();
    _sessionScore = 0;
    _statusFeedback = 'Spell at least ${level.targetWords} words to complete!';
    _statusFeedbackUrdu =
        'لیول مکمل کرنے کے لیے کم از کم ${level.targetWords} الفاظ بنائیں۔';
    _isLastActionSuccess = true;
    _recentlyUnlockedAchievement = null;
    notifyListeners();
  }

  void selectLetterAt(int index) {
    if (_selectedIndices.contains(index)) {
      // Tap on already selected tile removes it
      _selectedIndices.remove(index);
    } else {
      _selectedIndices.add(index);
    }
    AudioService.playTileTap();
    notifyListeners();
  }

  void removeLastLetter() {
    if (_selectedIndices.isNotEmpty) {
      _selectedIndices.removeLast();
      AudioService.playTileTap();
      notifyListeners();
    }
  }

  void clearCurrentWord() {
    if (_selectedIndices.isNotEmpty) {
      _selectedIndices.clear();
      AudioService.playTileTap();
      notifyListeners();
    }
  }

  void shuffleLetters() {
    _displayLetters.shuffle(Random());
    _selectedIndices.clear();
    AudioService.playTileTap();
    notifyListeners();
  }

  ValidationResult submitWord() {
    final res = submitDirectWord(currentWord);
    _selectedIndices.clear();
    notifyListeners();
    return res;
  }

  ValidationResult submitDirectWord(String word) {
    if (_currentLevel == null) return ValidationResult.emptyWord();

    final result = WordValidator.validate(
      submittedWord: word,
      level: _currentLevel!,
      alreadyFoundWords: _foundWords,
    );

    if (result.isValid) {
      final upperWord = word.toUpperCase();
      _foundWords.add(upperWord);
      final wordScore = ScoringEngine.getWordScore(upperWord);
      _sessionScore += wordScore;
      progress.totalScore += wordScore;
      progress.foundWords.add(upperWord);

      // Streak tracking
      progress.currentStreak += 1;
      if (progress.currentStreak > progress.highestStreak) {
        progress.highestStreak = progress.currentStreak;
      }

      final urduMeaning = wordRepository.getUrduMeaning(upperWord);
      _statusFeedback = '+$wordScore pts! "$upperWord": $urduMeaning';
      _statusFeedbackUrdu = urduMeaning;
      _isLastActionSuccess = true;

      AudioService.playWordSuccess();
      _checkAchievementsAfterWord();

      // Check level completion
      if (isLevelCompleted) {
        _handleLevelCompletion();
      }

      storageService.saveProgress(progress);
    } else {
      // Incorrect submission resets current streak
      progress.currentStreak = 0;
      _statusFeedback = result.message;
      _statusFeedbackUrdu = result.messageUrdu;
      _isLastActionSuccess = false;
      AudioService.playWordError();
    }

    notifyListeners();
    return result;
  }

  void _handleLevelCompletion() {
    if (_currentLevel == null) return;
    final scoreResult = ScoringEngine.calculateLevelCompletion(
      level: _currentLevel!,
      wordsFoundCount: _foundWords.length,
      progress: progress,
    );

    if (scoreResult.isFirstTimeCompletion) {
      progress.completedLevelIds.add(_currentLevel!.id);
      progress.coins += scoreResult.coinsEarned;
      progress.totalScore += scoreResult.bonusPointsEarned;
      progress.levelStars[_currentLevel!.id] = scoreResult.starsEarned;
    } else {
      // If replaying, update stars if higher
      final currentStars = progress.levelStars[_currentLevel!.id] ?? 0;
      if (scoreResult.starsEarned > currentStars) {
        progress.levelStars[_currentLevel!.id] = scoreResult.starsEarned;
      }
    }

    AudioService.playLevelComplete();
    _checkAchievementsAfterLevel();
  }

  HintResult useHint(HintType type) {
    if (_currentLevel == null) {
      return const HintResult(success: false, message: 'No active level');
    }

    final result = HintSystem.provideHint(
      type: type,
      level: _currentLevel!,
      foundWords: _foundWords,
      progress: progress,
      wordRepo: wordRepository,
    );

    if (result.success) {
      _statusFeedback = result.hintText ?? result.message ?? 'Hint used!';
      _statusFeedbackUrdu = 'اشارہ استعمال کیا گیا';
      _isLastActionSuccess = true;
      AudioService.playHint();
      storageService.saveProgress(progress);
    } else {
      _statusFeedback = result.message ?? 'Cannot use hint!';
      _statusFeedbackUrdu = 'اشارہ دستیاب نہیں ہے';
      _isLastActionSuccess = false;
    }

    notifyListeners();
    return result;
  }

  void _checkAchievementsAfterWord() {
    // 1. First word
    if (progress.foundWords.length >= 1 &&
        !progress.unlockedAchievementIds.contains('ach_first_word')) {
      _unlockAchievement('ach_first_word');
    }

    // 2. Streak 5
    if (progress.currentStreak >= 5 &&
        !progress.unlockedAchievementIds.contains('ach_streak_5')) {
      _unlockAchievement('ach_streak_5');
    }

    // 3. 100 words
    if (progress.foundWords.length >= 100 &&
        !progress.unlockedAchievementIds.contains('ach_hundred_words')) {
      _unlockAchievement('ach_hundred_words');
    }
  }

  void _checkAchievementsAfterLevel() {
    // 1. First completed level
    if (progress.completedLevelIds.length >= 1 &&
        !progress.unlockedAchievementIds.contains('ach_first_level')) {
      _unlockAchievement('ach_first_level');
    }

    // 2. 10 completed levels
    if (progress.completedLevelIds.length >= 10 &&
        !progress.unlockedAchievementIds.contains('ach_ten_levels')) {
      _unlockAchievement('ach_ten_levels');
    }

    // 3. 30 levels
    if (progress.completedLevelIds.length >= 30 &&
        !progress.unlockedAchievementIds.contains('ach_master_class')) {
      _unlockAchievement('ach_master_class');
    }

    // 4. 50 levels (Super Scholar)
    if (progress.completedLevelIds.length >= 50 &&
        !progress.unlockedAchievementIds.contains('ach_fifty_levels')) {
      _unlockAchievement('ach_fifty_levels');
    }
  }

  void _unlockAchievement(String achievementId) {
    progress.unlockedAchievementIds.add(achievementId);
    final ach = achievementRepository.getById(achievementId);
    if (ach != null) {
      progress.coins += ach.rewardCoins;
      _recentlyUnlockedAchievement = ach;
      AudioService.playAchievement();
    }
  }

  void clearRecentAchievement() {
    _recentlyUnlockedAchievement = null;
    notifyListeners();
  }
}
