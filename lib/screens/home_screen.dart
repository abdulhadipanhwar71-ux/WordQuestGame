import 'package:flutter/material.dart';
import '../data/achievement_repository.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../game/timed_challenge_engine.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';
import 'achievements_screen.dart';
import 'class_selection_screen.dart';
import 'gameplay_screen.dart';
import 'help_about_screen.dart';
import 'settings_screen.dart';
import 'word_learning_panel_screen.dart';

class HomeScreen extends StatefulWidget {
  final GameEngine gameEngine;
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final AchievementRepository achievementRepository;
  final StorageService storageService;

  const HomeScreen({
    Key? key,
    required this.gameEngine,
    required this.levelRepository,
    required this.wordRepository,
    required this.achievementRepository,
    required this.storageService,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final progress = widget.storageService.progress;
    final totalCompleted = progress.completedLevelIds.length;
    final totalLevels = widget.levelRepository.totalLevels;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with settings and help
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.monetization_on_rounded,
                                color: AppColors.goldCoin, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              '${progress.coins}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.stars_rounded,
                                color: AppColors.goldStar, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              '${progress.totalScore}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.help_outline_rounded,
                            color: AppColors.textDark),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HelpAboutScreen()),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings_rounded,
                            color: AppColors.textDark),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SettingsScreen(
                                storageService: widget.storageService,
                              ),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Hero Banner
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlueDark, AppColors.primaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Icons.school_rounded,
                        color: Colors.white, size: 56),
                    const SizedBox(height: 12),
                    const Text(
                      'Word Quest',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Text(
                      'WORD SCHOOL  •  لفظی درسگاہ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: totalLevels > 0
                            ? (totalCompleted / totalLevels)
                            : 0,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.goldCoin),
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalCompleted of $totalLevels Levels Mastered',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Big Action: Continue / Play Next
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow_rounded, size: 30),
                label: Text(
                  totalCompleted == 0
                      ? 'START PLAYING کھیلیں'
                      : 'CONTINUE QUEST اگلا لیول',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.successGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  elevation: 4,
                ),
                onPressed: () {
                  final nextNum = totalCompleted + 1;
                  final lvl = widget.levelRepository
                      .getLevelByNumber(nextNum <= 30 ? nextNum : 30);
                  if (lvl != null) {
                    widget.gameEngine.startLevel(lvl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameplayScreen(
                          gameEngine: widget.gameEngine,
                          levelRepository: widget.levelRepository,
                          wordRepository: widget.wordRepository,
                        ),
                      ),
                    ).then((_) => setState(() {}));
                  }
                },
              ),
              const SizedBox(height: 14),

              // School Classes Button
              OutlinedButton.icon(
                icon: const Icon(Icons.account_tree_rounded,
                    color: AppColors.primaryBlue),
                label: const Text(
                  'Select School Class (درجات کا انتخاب)',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side:
                      const BorderSide(color: AppColors.primaryBlue, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClassSelectionScreen(
                        gameEngine: widget.gameEngine,
                        levelRepository: widget.levelRepository,
                        wordRepository: widget.wordRepository,
                        storageService: widget.storageService,
                      ),
                    ),
                  ).then((_) => setState(() {}));
                },
              ),
              const SizedBox(height: 16),

              // Grid of secondary menu items
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.35,
                children: [
                  _buildMenuCard(
                    title: 'Word Learning',
                    titleUrdu: 'الفاظ و معانی',
                    icon: Icons.menu_book_rounded,
                    color: Colors.teal,
                    count: '${progress.foundWords.length} words',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WordLearningPanelScreen(
                            wordRepository: widget.wordRepository,
                            storageService: widget.storageService,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    title: 'Achievements',
                    titleUrdu: 'کامیابیاں',
                    icon: Icons.military_tech_rounded,
                    color: Colors.amber.shade800,
                    count: '${progress.unlockedAchievementIds.length} unlocked',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AchievementsScreen(
                            achievementRepository: widget.achievementRepository,
                            storageService: widget.storageService,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    title: 'Speed Challenge',
                    titleUrdu: 'وقت کا چیلنج',
                    icon: Icons.timer_rounded,
                    color: Colors.deepOrange,
                    count: '60s Mode',
                    onTap: () {
                      final timedEngine = TimedChallengeEngine(
                        levelRepository: widget.levelRepository,
                        wordRepository: widget.wordRepository,
                        storageService: widget.storageService,
                      );
                      timedEngine.startChallenge();
                      _showTimedChallengeDialog(context, timedEngine);
                    },
                  ),
                  _buildMenuCard(
                    title: 'School Guide',
                    titleUrdu: 'رہنمائی',
                    icon: Icons.info_outline_rounded,
                    color: Colors.indigo,
                    count: 'Instructions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HelpAboutScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String titleUrdu,
    required IconData icon,
    required Color color,
    required String count,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 28),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      count,
                      style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                titleUrdu,
                style: TextStyle(
                    fontSize: 12, color: color, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimedChallengeDialog(
      BuildContext context, TimedChallengeEngine engine) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _TimedChallengeDialog(engine: engine),
    ).then((_) => setState(() {}));
  }
}

class _TimedChallengeDialog extends StatefulWidget {
  final TimedChallengeEngine engine;
  const _TimedChallengeDialog({Key? key, required this.engine})
      : super(key: key);

  @override
  State<_TimedChallengeDialog> createState() => _TimedChallengeDialogState();
}

class _TimedChallengeDialogState extends State<_TimedChallengeDialog> {
  @override
  Widget build(BuildContext context) {
    final engine = widget.engine;
    return AnimatedBuilder(
      animation: engine,
      builder: (context, _) {
        if (engine.isGameOver) {
          return AlertDialog(
            title:
                const Text('⏱️ Time Up! وقت ختم', textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Final Score: ${engine.score} pts',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue),
                ),
                const SizedBox(height: 8),
                Text('Words Found: ${engine.foundWords.length}'),
                Text('Best Score: ${engine.progress.timedHighScore}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close بند کریں'),
              ),
              ElevatedButton(
                onPressed: () => engine.startChallenge(),
                child: const Text('Play Again دوبارہ کھیلیں'),
              ),
            ],
          );
        }

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '⏱️ ${engine.secondsRemaining}s',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: engine.secondsRemaining <= 10
                            ? Colors.red
                            : Colors.deepOrange,
                      ),
                    ),
                    Text(
                      'Score: ${engine.score}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        engine.dispose();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Divider(),
                // Display formed word
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    engine.currentWord.isEmpty
                        ? 'TAP LETTERS'
                        : engine.currentWord,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
                const SizedBox(height: 16),
                // Tiles
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(engine.letters.length, (i) {
                    final isSel = engine.selectedIndices.contains(i);
                    return ActionChip(
                      label: Text(
                        engine.letters[i],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isSel ? Colors.white : Colors.black87,
                        ),
                      ),
                      backgroundColor:
                          isSel ? AppColors.primaryBlue : Colors.grey.shade200,
                      onPressed: () => engine.selectLetterAt(i),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: engine.clear,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.successGreen),
                      onPressed: engine.submitWord,
                      child: const Text('Submit جمع کریں',
                          style: TextStyle(color: Colors.white)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.shuffle,
                          color: AppColors.primaryBlue),
                      onPressed: engine.shuffle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
