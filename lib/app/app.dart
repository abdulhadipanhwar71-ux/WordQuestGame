import 'package:flutter/material.dart';
import '../data/achievement_repository.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../screens/splash_screen.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class WordQuestApp extends StatelessWidget {
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final AchievementRepository achievementRepository;
  final StorageService storageService;
  final GameEngine gameEngine;

  const WordQuestApp({
    Key? key,
    required this.levelRepository,
    required this.wordRepository,
    required this.achievementRepository,
    required this.storageService,
    required this.gameEngine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Quest: Word School',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: SplashScreen(
        levelRepository: levelRepository,
        wordRepository: wordRepository,
        achievementRepository: achievementRepository,
        storageService: storageService,
        gameEngine: gameEngine,
      ),
    );
  }
}
