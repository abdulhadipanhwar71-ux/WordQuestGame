import 'package:flutter_test/flutter_test.dart';
import '../lib/data/scoring_config.dart';
import '../lib/game/scoring_engine.dart';
import '../lib/models/level.dart';
import '../lib/models/player_progress.dart';

void main() {
  group('Scoring Tests', () {
    test('Calculates word scores accurately by length', () {
      expect(ScoringConfig.calculateWordPoints('AT'), 2);
      expect(ScoringConfig.calculateWordPoints('CAT'), 5);
      expect(ScoringConfig.calculateWordPoints('CART'), 10);
      expect(ScoringConfig.calculateWordPoints('SMART'), 15);
      expect(ScoringConfig.calculateWordPoints('SCHOOL'), 20);
      expect(ScoringConfig.calculateWordPoints('GARDEN'), 20);
    });

    test('Awards one-time level bonus only on first completion', () {
      final sampleLevel = Level(
        id: 'lvl_01',
        levelNumber: 1,
        classId: 'class_1',
        className: 'Class 1',
        roomName: 'Classroom 101',
        letters: ['C', 'A', 'T'],
        validAnswers: ['CAT', 'ACT'],
        targetWords: 2,
        description: 'Test',
        minWordLength: 3,
        rewardCoins: 20,
        rewardStars: 3,
      );

      final progress = PlayerProgress();

      // First time completion
      final result1 = ScoringEngine.calculateLevelCompletion(
        level: sampleLevel,
        wordsFoundCount: 2,
        progress: progress,
      );

      expect(result1.isFirstTimeCompletion, true);
      expect(result1.bonusPointsEarned, 20);
      expect(result1.coinsEarned, 20);
      expect(result1.starsEarned, 3);

      // Simulate applying completion to progress
      progress.completedLevelIds.add(sampleLevel.id);

      // Second time completion
      final result2 = ScoringEngine.calculateLevelCompletion(
        level: sampleLevel,
        wordsFoundCount: 2,
        progress: progress,
      );

      expect(result2.isFirstTimeCompletion, false);
      expect(result2.bonusPointsEarned, 0); // No double bonuses!
      expect(result2.coinsEarned, 0);
    });
  });
}
