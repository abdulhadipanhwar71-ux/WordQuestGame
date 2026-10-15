class WordEntry {
  final String word;
  final String urduMeaning;
  final String exampleSentence;
  final String exampleSentenceUrdu;
  final int points;
  final bool isFound;
  final String? discoveredInLevelId;

  const WordEntry({
    required this.word,
    required this.urduMeaning,
    this.exampleSentence = '',
    this.exampleSentenceUrdu = '',
    required this.points,
    this.isFound = false,
    this.discoveredInLevelId,
  });

  WordEntry copyWith({
    String? word,
    String? urduMeaning,
    String? exampleSentence,
    String? exampleSentenceUrdu,
    int? points,
    bool? isFound,
    String? discoveredInLevelId,
  }) {
    return WordEntry(
      word: word ?? this.word,
      urduMeaning: urduMeaning ?? this.urduMeaning,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      exampleSentenceUrdu: exampleSentenceUrdu ?? this.exampleSentenceUrdu,
      points: points ?? this.points,
      isFound: isFound ?? this.isFound,
      discoveredInLevelId: discoveredInLevelId ?? this.discoveredInLevelId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'urduMeaning': urduMeaning,
      'exampleSentence': exampleSentence,
      'exampleSentenceUrdu': exampleSentenceUrdu,
      'points': points,
      'isFound': isFound,
      'discoveredInLevelId': discoveredInLevelId,
    };
  }

  factory WordEntry.fromJson(Map<String, dynamic> json) {
    return WordEntry(
      word: json['word'] as String,
      urduMeaning: json['urduMeaning'] as String? ?? '',
      exampleSentence: json['exampleSentence'] as String? ?? '',
      exampleSentenceUrdu: json['exampleSentenceUrdu'] as String? ?? '',
      points: json['points'] as int? ?? 5,
      isFound: json['isFound'] as bool? ?? false,
      discoveredInLevelId: json['discoveredInLevelId'] as String?,
    );
  }
}
