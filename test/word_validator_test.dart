import 'package:flutter_test/flutter_test.dart';
import '../lib/game/word_validator.dart';
import '../lib/models/level.dart';

void main() {
  group('WordValidator Tests', () {
    final sampleLevel = Level(
      id: 'lvl_test',
      levelNumber: 1,
      classId: 'class_1',
      className: 'Class 1: Beginner',
      roomName: 'Classroom 101',
      letters: ['C', 'A', 'T', 'R'],
      validAnswers: ['CAT', 'CAR', 'RAT', 'ART', 'CART'],
      targetWords: 3,
      description: 'Test level',
      minWordLength: 3,
      rewardCoins: 20,
      rewardStars: 3,
    );

    test('Accepts valid approved word', () {
      final result = WordValidator.validate(
        submittedWord: 'CAT',
        level: sampleLevel,
        alreadyFoundWords: {},
      );
      expect(result.isValid, true);
      expect(result.status, WordValidationStatus.success);
    });

    test('Rejects invalid word not in approved list', () {
      final result = WordValidator.validate(
        submittedWord: 'TAR', // Not in this level's validAnswers
        level: sampleLevel,
        alreadyFoundWords: {},
      );
      expect(result.isValid, false);
      expect(result.status, WordValidationStatus.notInApprovedList);
    });

    test(
        'Enforces letter frequency: cannot use letter more times than provided',
        () {
      final result = WordValidator.validate(
        submittedWord:
            'TAT', // uses 'T' twice, but sampleLevel has only one 'T'
        level: sampleLevel,
        alreadyFoundWords: {},
      );
      expect(result.isValid, false);
      expect(result.status, WordValidationStatus.letterCountExceeded);
    });

    test('Rejects unpermitted letters not present in puzzle', () {
      final result = WordValidator.validate(
        submittedWord: 'BAT', // 'B' not in ['C','A','T','R']
        level: sampleLevel,
        alreadyFoundWords: {},
      );
      expect(result.isValid, false);
      expect(result.status, WordValidationStatus.unpermittedLetters);
    });

    test('Rejects words below minimum length', () {
      final result = WordValidator.validate(
        submittedWord: 'AT',
        level: sampleLevel,
        alreadyFoundWords: {},
      );
      expect(result.isValid, false);
      expect(result.status, WordValidationStatus.tooShort);
    });

    test('Rejects duplicate words (case-insensitive)', () {
      final result = WordValidator.validate(
        submittedWord: 'cat',
        level: sampleLevel,
        alreadyFoundWords: {'CAT'},
      );
      expect(result.isValid, false);
      expect(result.status, WordValidationStatus.alreadyFound);
    });
  });
}
