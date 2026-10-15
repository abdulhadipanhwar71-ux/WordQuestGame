import 'dart:convert';

class PlayerProgress {
  int coins;
  int totalScore;
  int currentStreak;
  int highestStreak;
  Set<String> completedLevelIds;
  Map<String, int> levelStars; // levelId -> stars (1-3)
  Set<String> foundWords;
  Set<String> unlockedAchievementIds;
  bool soundEnabled;
  bool hapticsEnabled;
  bool pronunciationEnabled;
  bool animationsEnabled;
  bool timedModeUnlocked;
  int timedHighScore;

  PlayerProgress({
    this.coins = 60, // starting balance for hint testing
    this.totalScore = 0,
    this.currentStreak = 0,
    this.highestStreak = 0,
    Set<String>? completedLevelIds,
    Map<String, int>? levelStars,
    Set<String>? foundWords,
    Set<String>? unlockedAchievementIds,
    this.soundEnabled = true,
    this.hapticsEnabled = true,
    this.pronunciationEnabled = true,
    this.animationsEnabled = true,
    this.timedModeUnlocked = false,
    this.timedHighScore = 0,
  })  : completedLevelIds = completedLevelIds ?? {},
        levelStars = levelStars ?? {},
        foundWords = foundWords ?? {},
        unlockedAchievementIds = unlockedAchievementIds ?? {};

  bool isLevelUnlocked(int levelNumber) {
    if (levelNumber <= 1) return true;
    final previousLevelId =
        'lvl_${(levelNumber - 1).toString().padLeft(2, '0')}';
    return completedLevelIds.contains(previousLevelId);
  }

  bool isLevelCompleted(String levelId) {
    return completedLevelIds.contains(levelId);
  }

  int getStarsForLevel(String levelId) {
    return levelStars[levelId] ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'coins': coins,
      'totalScore': totalScore,
      'currentStreak': currentStreak,
      'highestStreak': highestStreak,
      'completedLevelIds': completedLevelIds.toList(),
      'levelStars': levelStars,
      'foundWords': foundWords.toList(),
      'unlockedAchievementIds': unlockedAchievementIds.toList(),
      'soundEnabled': soundEnabled,
      'hapticsEnabled': hapticsEnabled,
      'pronunciationEnabled': pronunciationEnabled,
      'animationsEnabled': animationsEnabled,
      'timedModeUnlocked': timedModeUnlocked,
      'timedHighScore': timedHighScore,
    };
  }

  factory PlayerProgress.fromMap(Map<String, dynamic> map) {
    return PlayerProgress(
      coins: map['coins'] as int? ?? 60,
      totalScore: map['totalScore'] as int? ?? 0,
      currentStreak: map['currentStreak'] as int? ?? 0,
      highestStreak: map['highestStreak'] as int? ?? 0,
      completedLevelIds: (map['completedLevelIds'] as List?)
              ?.map((e) => e.toString())
              .toSet() ??
          {},
      levelStars: (map['levelStars'] as Map?)
              ?.map((k, v) => MapEntry(k.toString(), (v as num).toInt())) ??
          {},
      foundWords:
          (map['foundWords'] as List?)?.map((e) => e.toString()).toSet() ?? {},
      unlockedAchievementIds: (map['unlockedAchievementIds'] as List?)
              ?.map((e) => e.toString())
              .toSet() ??
          {},
      soundEnabled: map['soundEnabled'] as bool? ?? true,
      hapticsEnabled: map['hapticsEnabled'] as bool? ?? true,
      pronunciationEnabled: map['pronunciationEnabled'] as bool? ?? true,
      animationsEnabled: map['animationsEnabled'] as bool? ?? true,
      timedModeUnlocked: map['timedModeUnlocked'] as bool? ?? false,
      timedHighScore: map['timedHighScore'] as int? ?? 0,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PlayerProgress.fromJson(String source) =>
      PlayerProgress.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
