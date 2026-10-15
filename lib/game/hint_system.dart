import '../data/scoring_config.dart';
import '../data/word_repository.dart';
import '../models/level.dart';
import '../models/player_progress.dart';

enum HintType {
  firstLetter,
  wordLength,
  urduMeaning,
  sentenceClue,
}

class HintResult {
  final bool success;
  final String? message;
  final String? hintText;
  final String? targetWord;
  final int coinsDeducted;

  const HintResult({
    required this.success,
    this.message,
    this.hintText,
    this.targetWord,
    this.coinsDeducted = 0,
  });
}

class HintSystem {
  static int getCost(HintType type) {
    switch (type) {
      case HintType.firstLetter:
        return ScoringConfig.costRevealFirstLetter;
      case HintType.wordLength:
        return ScoringConfig.costRevealWordLength;
      case HintType.urduMeaning:
        return ScoringConfig.costRevealUrduMeaning;
      case HintType.sentenceClue:
        return ScoringConfig.costRevealSentenceClue;
    }
  }

  static HintResult provideHint({
    required HintType type,
    required Level level,
    required Set<String> foundWords,
    required PlayerProgress progress,
    required WordRepository wordRepo,
  }) {
    final cost = getCost(type);

    if (progress.coins < cost) {
      return HintResult(
        success: false,
        message: 'Not enough coins! You need $cost coins for this hint.',
      );
    }

    // Find undiscovered words
    final upperFound = foundWords.map((w) => w.toUpperCase()).toSet();
    final undiscovered = level.validAnswers
        .where((w) => !upperFound.contains(w.toUpperCase()))
        .toList();

    if (undiscovered.isEmpty) {
      return const HintResult(
        success: false,
        message: 'All approved words have already been found!',
      );
    }

    // Pick first undiscovered word
    final target = undiscovered.first;

    // Deduct coins safely
    progress.coins -= cost;

    switch (type) {
      case HintType.firstLetter:
        final firstChar = target[0];
        return HintResult(
          success: true,
          targetWord: target,
          coinsDeducted: cost,
          hintText: 'An undiscovered word starts with letter: "$firstChar"',
          message: 'Hint: Starts with "$firstChar"',
        );

      case HintType.wordLength:
        final len = target.length;
        return HintResult(
          success: true,
          targetWord: target,
          coinsDeducted: cost,
          hintText: 'There is an undiscovered word with $len letters.',
          message: 'Hint: $len letters long',
        );

      case HintType.urduMeaning:
        final urdu = wordRepo.getUrduMeaning(target);
        return HintResult(
          success: true,
          targetWord: target,
          coinsDeducted: cost,
          hintText: 'Meaning of an undiscovered word:\n$urdu',
          message: 'Urdu Clue: $urdu',
        );

      case HintType.sentenceClue:
        final sentence = wordRepo.getExampleSentence(target);
        final regex = RegExp(RegExp.escape(target), caseSensitive: false);
        final blanked = sentence.replaceAll(regex, '_____');
        return HintResult(
          success: true,
          targetWord: target,
          coinsDeducted: cost,
          hintText: 'Sentence Clue (Fill in the blank):\n"$blanked"',
          message: 'Sentence: "$blanked"',
        );
    }
  }
}
