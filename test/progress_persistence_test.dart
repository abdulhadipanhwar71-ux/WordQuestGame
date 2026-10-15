import 'package:flutter_test/flutter_test.dart';
import '../lib/models/player_progress.dart';

void main() {
  group('PlayerProgress & Persistence Tests', () {
    test('Serializes to JSON and restores state cleanly', () {
      final initial = PlayerProgress(
        coins: 140,
        totalScore: 350,
        currentStreak: 4,
        highestStreak: 7,
        completedLevelIds: {'lvl_01', 'lvl_02', 'lvl_03'},
        levelStars: {'lvl_01': 3, 'lvl_02': 2, 'lvl_03': 3},
        foundWords: {'CAT', 'ACT', 'DOG', 'GOD'},
        unlockedAchievementIds: {'ach_first_word', 'ach_first_level'},
        soundEnabled: true,
        hapticsEnabled: false,
      );

      final jsonString = initial.toJson();
      final restored = PlayerProgress.fromJson(jsonString);

      expect(restored.coins, 140);
      expect(restored.totalScore, 350);
      expect(restored.currentStreak, 4);
      expect(restored.highestStreak, 7);
      expect(restored.completedLevelIds.contains('lvl_01'), true);
      expect(restored.completedLevelIds.contains('lvl_02'), true);
      expect(restored.getStarsForLevel('lvl_01'), 3);
      expect(restored.getStarsForLevel('lvl_02'), 2);
      expect(restored.foundWords.contains('CAT'), true);
      expect(restored.unlockedAchievementIds.contains('ach_first_word'), true);
      expect(restored.hapticsEnabled, false);
    });

    test('Unlocks next level sequentially', () {
      final progress = PlayerProgress();
      // Level 1 is always unlocked
      expect(progress.isLevelUnlocked(1), true);
      // Level 2 is locked initially
      expect(progress.isLevelUnlocked(2), false);

      // Complete Level 1
      progress.completedLevelIds.add('lvl_01');
      // Level 2 should now be unlocked
      expect(progress.isLevelUnlocked(2), true);
      // Level 3 is still locked
      expect(progress.isLevelUnlocked(3), false);
    });
  });
}
