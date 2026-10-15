import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/level.dart';

class LevelRepository {
  List<Level> _levels = [];

  List<Level> get levels => _levels;

  bool get isLoaded => _levels.isNotEmpty;

  Future<void> loadLevels({String? jsonString}) async {
    final raw =
        jsonString ?? await rootBundle.loadString('assets/data/levels.json');
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    _levels = list
        .map((item) => Level.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void loadFromList(List<Level> levels) {
    _levels = levels;
  }

  Level? getLevelById(String id) {
    try {
      return _levels.firstWhere((lvl) => lvl.id == id);
    } catch (_) {
      return null;
    }
  }

  Level? getLevelByNumber(int number) {
    try {
      return _levels.firstWhere((lvl) => lvl.levelNumber == number);
    } catch (_) {
      return null;
    }
  }

  List<Level> getLevelsForClass(String classId) {
    return _levels.where((lvl) => lvl.classId == classId).toList();
  }

  int get totalLevels => _levels.length;
}
