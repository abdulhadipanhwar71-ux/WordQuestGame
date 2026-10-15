import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/achievement.dart';

class AchievementRepository {
  List<Achievement> _achievements = [];

  List<Achievement> get achievements => _achievements;

  bool get isLoaded => _achievements.isNotEmpty;

  Future<void> loadAchievements({String? jsonString}) async {
    final raw = jsonString ??
        await rootBundle.loadString('assets/data/achievements.json');
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    _achievements = list
        .map((item) => Achievement.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void loadFromList(List<Achievement> list) {
    _achievements = list;
  }

  Achievement? getById(String id) {
    try {
      return _achievements.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}
