import 'package:flutter_test/flutter_test.dart';
import '../lib/data/word_repository.dart';
import '../lib/game/hint_system.dart';
import '../lib/models/level.dart';
import '../lib/models/player_progress.dart';

void main() {
  group('Hint System Tests', () {
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

    final wordRepo = WordRepository();
    wordRepo.loadFromMaps(
      {
        'CAT': 'بلی (Cat)',
        'ACT': 'عمل کرنا (Act)',
      },
      {'CAT', 'ACT'},
      {
        'CAT': {
          'sentence': 'The cat drinks warm milk.',
          'sentence_urdu': 'بلی گرم دودھ پیتی ہے۔',
        },
        'ACT': {
          'sentence': 'Always act with honesty.',
          'sentence_urdu': 'ہمیشہ دیانت داری سے کام لیں۔',
        },
      },
    );

    test('Deducts coins accurately when purchasing hint', () {
      final progress = PlayerProgress(coins: 50);

      final result = HintSystem.provideHint(
        type: HintType.firstLetter,
        level: sampleLevel,
        foundWords: {},
        progress: progress,
        wordRepo: wordRepo,
      );

      expect(result.success, true);
      expect(result.coinsDeducted, 10);
      expect(progress.coins, 40);
      expect(result.targetWord, 'CAT');
    });

    test('Rejects hint when coins are insufficient', () {
      final progress = PlayerProgress(
          coins: 4); // Needs at least 5 for length, 10 for letter

      final result = HintSystem.provideHint(
        type: HintType.wordLength,
        level: sampleLevel,
        foundWords: {},
        progress: progress,
        wordRepo: wordRepo,
      );

      expect(result.success, false);
      expect(progress.coins, 4); // No coins deducted
    });

    test('Does not reveal already found words in hint', () {
      final progress = PlayerProgress(coins: 50);

      // 'CAT' is already found, so hint must target 'ACT'
      final result = HintSystem.provideHint(
        type: HintType.firstLetter,
        level: sampleLevel,
        foundWords: {'CAT'},
        progress: progress,
        wordRepo: wordRepo,
      );

      expect(result.success, true);
      expect(result.targetWord, 'ACT');
    });

    test('Provides sentence clue with word blanked out and deducts 15 coins',
        () {
      final progress = PlayerProgress(coins: 50);

      final result = HintSystem.provideHint(
        type: HintType.sentenceClue,
        level: sampleLevel,
        foundWords: {},
        progress: progress,
        wordRepo: wordRepo,
      );

      expect(result.success, true);
      expect(result.coinsDeducted, 15);
      expect(progress.coins, 35);
      expect(result.hintText?.contains('_____'), true);
    });
  });
}
