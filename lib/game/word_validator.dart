import '../models/level.dart';

enum WordValidationStatus {
  success,
  alreadyFound,
  notInApprovedList,
  letterCountExceeded,
  unpermittedLetters,
  tooShort,
  emptyWord,
}

class ValidationResult {
  final WordValidationStatus status;
  final String message;
  final String messageUrdu;
  final bool isValid;

  const ValidationResult({
    required this.status,
    required this.message,
    required this.messageUrdu,
    required this.isValid,
  });

  factory ValidationResult.success() {
    return const ValidationResult(
      status: WordValidationStatus.success,
      message: 'Great job! Word accepted.',
      messageUrdu: 'شاباش! لفظ درست ہے۔',
      isValid: true,
    );
  }

  factory ValidationResult.alreadyFound(String word) {
    return ValidationResult(
      status: WordValidationStatus.alreadyFound,
      message: '"$word" is already found!',
      messageUrdu: 'یہ لفظ پہلے ہی تلاش کیا جا چکا ہے!',
      isValid: false,
    );
  }

  factory ValidationResult.notInApprovedList(String word) {
    return ValidationResult(
      status: WordValidationStatus.notInApprovedList,
      message: '"$word" is not in this puzzle\'s approved words.',
      messageUrdu: 'یہ لفظ اس پہیلی کے منظور شدہ الفاظ میں شامل نہیں ہے۔',
      isValid: false,
    );
  }

  factory ValidationResult.letterCountExceeded(String char) {
    return ValidationResult(
      status: WordValidationStatus.letterCountExceeded,
      message: 'Letter "$char" used more times than available.',
      messageUrdu: 'حرف ضرورت سے زیادہ بار استعمال کیا گیا ہے۔',
      isValid: false,
    );
  }

  factory ValidationResult.unpermittedLetters() {
    return const ValidationResult(
      status: WordValidationStatus.unpermittedLetters,
      message: 'Word contains letters not provided in this puzzle.',
      messageUrdu: 'اس لفظ میں نا منظور شدہ حروف شامل ہیں۔',
      isValid: false,
    );
  }

  factory ValidationResult.tooShort(int minLength) {
    return ValidationResult(
      status: WordValidationStatus.tooShort,
      message: 'Word must have at least $minLength letters.',
      messageUrdu: 'لفظ میں کم از کم $minLength حروف ہونے چاہئیں۔',
      isValid: false,
    );
  }

  factory ValidationResult.emptyWord() {
    return const ValidationResult(
      status: WordValidationStatus.emptyWord,
      message: 'Please tap letters to spell a word first.',
      messageUrdu: 'پہلے حروف منتخب کر کے لفظ بنائیں۔',
      isValid: false,
    );
  }
}

class WordValidator {
  static ValidationResult validate({
    required String submittedWord,
    required Level level,
    required Set<String> alreadyFoundWords,
  }) {
    final word = submittedWord.trim().toUpperCase();

    if (word.isEmpty) {
      return ValidationResult.emptyWord();
    }

    if (word.length < level.minWordLength) {
      return ValidationResult.tooShort(level.minWordLength);
    }

    // Check letter frequency
    final Map<String, int> puzzleLetterFreq = {};
    for (final char in level.letters) {
      final upper = char.toUpperCase();
      puzzleLetterFreq[upper] = (puzzleLetterFreq[upper] ?? 0) + 1;
    }

    final Map<String, int> wordLetterFreq = {};
    for (int i = 0; i < word.length; i++) {
      final char = word[i];
      if (!puzzleLetterFreq.containsKey(char)) {
        return ValidationResult.unpermittedLetters();
      }
      wordLetterFreq[char] = (wordLetterFreq[char] ?? 0) + 1;
      if (wordLetterFreq[char]! > puzzleLetterFreq[char]!) {
        return ValidationResult.letterCountExceeded(char);
      }
    }

    // Check if already found (case-insensitive)
    final upperFound = alreadyFoundWords.map((w) => w.toUpperCase()).toSet();
    if (upperFound.contains(word)) {
      return ValidationResult.alreadyFound(word);
    }

    // Check if approved in level
    final upperApproved =
        level.validAnswers.map((w) => w.toUpperCase()).toSet();
    if (!upperApproved.contains(word)) {
      return ValidationResult.notInApprovedList(word);
    }

    return ValidationResult.success();
  }
}
