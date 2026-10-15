import 'package:flutter/material.dart';
import 'app/app.dart';
import 'data/achievement_repository.dart';
import 'data/level_repository.dart';
import 'data/word_repository.dart';
import 'game/game_engine.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final levelRepository = LevelRepository();
  final wordRepository = WordRepository();
  final achievementRepository = AchievementRepository();
  final storageService = StorageService();

  final gameEngine = GameEngine(
    levelRepository: levelRepository,
    wordRepository: wordRepository,
    achievementRepository: achievementRepository,
    storageService: storageService,
  );

  runApp(
    WordQuestApp(
      levelRepository: levelRepository,
      wordRepository: wordRepository,
      achievementRepository: achievementRepository,
      storageService: storageService,
      gameEngine: gameEngine,
    ),
  );
}
