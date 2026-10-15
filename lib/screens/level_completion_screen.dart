import 'package:flutter/material.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../models/level.dart';
import '../theme/app_colors.dart';
import 'gameplay_screen.dart';
import 'word_learning_panel_screen.dart';

class LevelCompletionScreen extends StatelessWidget {
  final Level level;
  final GameEngine gameEngine;
  final LevelRepository levelRepository;
  final WordRepository wordRepository;

  const LevelCompletionScreen({
    Key? key,
    required this.level,
    required this.gameEngine,
    required this.levelRepository,
    required this.wordRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = gameEngine.progress;
    final stars = progress.getStarsForLevel(level.id);
    final nextLevel = levelRepository.getLevelByNumber(level.levelNumber + 1);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 80,
                color: AppColors.goldCoin,
              ),
              const SizedBox(height: 16),
              const Text(
                'Classroom Cleared!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryBlueDark,
                ),
              ),
              const Text(
                'کامیابی! آپ نے یہ لیول مکمل کر لیا ہے',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.star_rounded,
                      size: 40,
                      color: i < (stars > 0 ? stars : 2)
                          ? AppColors.goldStar
                          : Colors.grey.shade300,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildStatRow(
                          'Total Player Score:', '${progress.totalScore} pts'),
                      const Divider(),
                      _buildStatRow('Total Player Coins:', '${progress.coins}'),
                      const Divider(),
                      _buildStatRow('Words Discovered in Level:',
                          '${gameEngine.foundWords.length} words'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (nextLevel != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    gameEngine.startLevel(nextLevel);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameplayScreen(
                          gameEngine: gameEngine,
                          levelRepository: levelRepository,
                          wordRepository: wordRepository,
                        ),
                      ),
                    );
                  },
                  child: Text('Next: Level ${nextLevel.levelNumber} اگلا لیول'),
                )
              else
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '🎓 Congratulations! You completed all 50 levels of Word School!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.brown),
                  ),
                ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WordLearningPanelScreen(
                        wordRepository: wordRepository,
                        storageService: gameEngine.storageService,
                      ),
                    ),
                  );
                },
                child: const Text('Review Vocabulary الفاظ دیکھیں'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Return to School Home واپس'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
        Text(value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
