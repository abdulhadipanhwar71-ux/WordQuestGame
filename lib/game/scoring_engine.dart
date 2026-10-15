import '../data/scoring_config.dart';
import '../models/level.dart';
import '../models/player_progress.dart';

class ScoreResult {
  final int pointsEarned;
  final int bonusPointsEarned;
  final int coinsEarned;
  final int starsEarned;
  final bool isFirstTimeCompletion;

  const ScoreResult({
    required this.pointsEarned,
    required this.bonusPointsEarned,
    required this.coinsEarned,
    required this.starsEarned,
    required this.isFirstTimeCompletion,
  });
}

class ScoringEngine {
  static int getWordScore(String word) {
    return ScoringConfig.calculateWordPoints(word);
  }

  static ScoreResult calculateLevelCompletion({
    required Level level,
    required int wordsFoundCount,
    required PlayerProgress progress,
  }) {
    final bool isFirstTime = !progress.isLevelCompleted(level.id);

    // Calculate stars
    int stars = 1;
    if (wordsFoundCount >= level.validAnswers.length) {
      stars = 3; // Found all words!
    } else if (wordsFoundCount >= level.targetWords) {
      stars = 2; // Met target
    }

    int bonusPoints = 0;
    int coins = 0;

    if (isFirstTime) {
      bonusPoints = ScoringConfig.levelCompletionBonusPoints;
      coins = level.rewardCoins;
    }

    return ScoreResult(
      pointsEarned: 0,
      bonusPointsEarned: bonusPoints,
      coinsEarned: coins,
      starsEarned: stars,
      isFirstTimeCompletion: isFirstTime,
    );
  }
}
