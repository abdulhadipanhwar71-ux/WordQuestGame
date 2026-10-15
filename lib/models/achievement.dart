class Achievement {
  final String id;
  final String title;
  final String titleUrdu;
  final String description;
  final String icon;
  final int requiredCount;
  final String type; // 'word_count', 'level_count', 'streak'
  final int rewardCoins;
  final bool isUnlocked;
  final String? unlockedDate;

  const Achievement({
    required this.id,
    required this.title,
    required this.titleUrdu,
    required this.description,
    required this.icon,
    required this.requiredCount,
    required this.type,
    required this.rewardCoins,
    this.isUnlocked = false,
    this.unlockedDate,
  });

  Achievement copyWith({
    bool? isUnlocked,
    String? unlockedDate,
  }) {
    return Achievement(
      id: id,
      title: title,
      titleUrdu: titleUrdu,
      description: description,
      icon: icon,
      requiredCount: requiredCount,
      type: type,
      rewardCoins: rewardCoins,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedDate: unlockedDate ?? this.unlockedDate,
    );
  }

  factory Achievement.fromJson(Map<String, dynamic> json,
      {bool isUnlocked = false, String? unlockedDate}) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      titleUrdu: json['title_urdu'] as String? ?? '',
      description: json['description'] as String,
      icon: json['icon'] as String,
      requiredCount: json['required_count'] as int,
      type: json['type'] as String,
      rewardCoins: json['reward_coins'] as int,
      isUnlocked: isUnlocked,
      unlockedDate: unlockedDate,
    );
  }
}
