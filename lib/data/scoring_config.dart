class ScoringConfig {
  static const int pointsForTwoLetterWord = 2;
  static const int pointsForThreeLetterWord = 5;
  static const int pointsForFourLetterWord = 10;
  static const int pointsForFiveLetterWord = 15;
  static const int pointsForSixOrMoreLetterWord = 20;

  static const int levelCompletionBonusPoints = 20;

  // Hint costs
  static const int costRevealFirstLetter = 10;
  static const int costRevealWordLength = 5;
  static const int costRevealUrduMeaning = 15;
  static const int costRevealSentenceClue = 15;

  static int calculateWordPoints(String word) {
    final len = word.length;
    if (len == 2) return pointsForTwoLetterWord;
    if (len == 3) return pointsForThreeLetterWord;
    if (len == 4) return pointsForFourLetterWord;
    if (len == 5) return pointsForFiveLetterWord;
    if (len >= 6) return pointsForSixOrMoreLetterWord;
    return 0;
  }
}
