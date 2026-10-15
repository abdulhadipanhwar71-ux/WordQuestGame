class Level {
  final String id;
  final int levelNumber;
  final String classId;
  final String className;
  final String roomName;
  final List<String> letters;
  final List<String> validAnswers;
  final int targetWords;
  final String description;
  final int minWordLength;
  final int rewardCoins;
  final int rewardStars;

  const Level({
    required this.id,
    required this.levelNumber,
    required this.classId,
    required this.className,
    required this.roomName,
    required this.letters,
    required this.validAnswers,
    required this.targetWords,
    required this.description,
    required this.minWordLength,
    required this.rewardCoins,
    required this.rewardStars,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'] as String,
      levelNumber: json['level_number'] as int,
      classId: json['class_id'] as String,
      className: json['class_name'] as String,
      roomName: json['room_name'] as String,
      letters: List<String>.from(json['letters'] as List),
      validAnswers: List<String>.from(json['valid_answers'] as List),
      targetWords: json['target_words'] as int,
      description: json['description'] as String,
      minWordLength: json['min_word_length'] as int,
      rewardCoins: json['reward_coins'] as int,
      rewardStars: json['reward_stars'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level_number': levelNumber,
      'class_id': classId,
      'class_name': className,
      'room_name': roomName,
      'letters': letters,
      'valid_answers': validAnswers,
      'target_words': targetWords,
      'description': description,
      'min_word_length': minWordLength,
      'reward_coins': rewardCoins,
      'reward_stars': rewardStars,
    };
  }
}
