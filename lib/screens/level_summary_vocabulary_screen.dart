import 'package:flutter/material.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../models/level.dart';
import '../services/audio_service.dart';
import '../theme/app_colors.dart';
import '../widgets/falling_petals_overlay.dart';
import 'gameplay_screen.dart';
import 'word_learning_panel_screen.dart';

class LevelSummaryVocabularyScreen extends StatelessWidget {
  final Level level;
  final GameEngine gameEngine;
  final LevelRepository levelRepository;
  final WordRepository wordRepository;

  const LevelSummaryVocabularyScreen({
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
    final targetWords = level.validAnswers;

    return FallingPetalsOverlay(
      isEnabled: progress.animationsEnabled,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          title: Text('Level ${level.levelNumber} Completed!'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Celebration Header Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlueDark, AppColors.primaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      '🌸 EXCELLENT WORK! شاباش 🌸',
                      style: TextStyle(
                        color: AppColors.goldCoin,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${level.roomName} • ${level.className}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    // Stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (idx) {
                        final awarded = idx < (stars > 0 ? stars : 2);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.star_rounded,
                            size: 38,
                            color:
                                awarded ? AppColors.goldStar : Colors.white24,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    // Coins and points badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.monetization_on_rounded,
                                  color: AppColors.goldCoin, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                '+${level.rewardCoins} Coins',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.stars_rounded,
                                  color: AppColors.goldStar, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                '+20 Score Pts',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Title for Vocabulary List
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Level Vocabulary (سبق کے الفاظ و معانی):',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primaryBlueDark,
                      ),
                    ),
                    Text(
                      '${targetWords.length} words',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
              ),

              // Scrollable Word Details Cards
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: targetWords.length,
                  itemBuilder: (context, index) {
                    final word = targetWords[index];
                    final meaning = wordRepository.getUrduMeaning(word);
                    final sentence = wordRepository.getExampleSentence(word);
                    final sentenceUrdu =
                        wordRepository.getExampleSentenceUrdu(word);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Word Header + Pronunciation Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryBlue
                                            .withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '#${index + 1}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryBlue,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      word,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primaryBlueDark,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.volume_up_rounded,
                                      color: AppColors.primaryBlue, size: 26),
                                  tooltip: 'Pronounce Word تلفظ سنیں',
                                  onPressed: () {
                                    AudioService.speakWord(word);
                                  },
                                ),
                              ],
                            ),
                            const Divider(height: 16),
                            // Urdu Meaning
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Urdu Meaning: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.black54),
                                ),
                                Expanded(
                                  child: Text(
                                    meaning,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.successGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Example Sentence
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.format_quote_rounded,
                                          size: 16, color: Colors.blueGrey),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          sentence,
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    sentenceUrdu,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Control Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (nextLevel != null)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
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
                        child: Text(
                          'Continue to Level ${nextLevel.levelNumber} اگلا لیول جاری رکھیں',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successGreen,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Return to School Home واپس اسکول جائیں',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
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
                            icon: const Icon(Icons.menu_book_rounded, size: 18),
                            label: const Text('Vocabulary Panel'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              gameEngine.startLevel(level);
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
                            icon: const Icon(Icons.replay_rounded, size: 18),
                            label: const Text('Replay Level'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
