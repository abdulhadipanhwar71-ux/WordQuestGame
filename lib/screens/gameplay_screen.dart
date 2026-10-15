import 'package:flutter/material.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../services/audio_service.dart';
import '../theme/app_colors.dart';
import '../widgets/found_words_grid.dart';
import '../widgets/hint_dialog.dart';
import '../widgets/school_room_background.dart';
import '../widgets/score_board.dart';
import '../widgets/swipe_word_canvas.dart';
import 'level_summary_vocabulary_screen.dart';

class GameplayScreen extends StatefulWidget {
  final GameEngine gameEngine;
  final LevelRepository levelRepository;
  final WordRepository wordRepository;

  const GameplayScreen({
    Key? key,
    required this.gameEngine,
    required this.levelRepository,
    required this.wordRepository,
  }) : super(key: key);

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  bool _hasShownCompletionModal = false;

  @override
  void initState() {
    super.initState();
    _hasShownCompletionModal = false;
  }

  void _onWordFoundTap(String word) {
    final meaning = widget.wordRepository.getUrduMeaning(word);
    final sentence = widget.wordRepository.getExampleSentence(word);
    final sentenceUrdu = widget.wordRepository.getExampleSentenceUrdu(word);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      word,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryBlueDark,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.volume_up_rounded,
                          color: AppColors.primaryBlue, size: 28),
                      tooltip: 'Pronounce Word',
                      onPressed: () => AudioService.speakWord(word),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Discovered پہچانا گیا',
                    style: TextStyle(
                        color: AppColors.successGreen,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            const Text(
              'Urdu Meaning (اردو ترجمہ و مفہوم):',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              meaning,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sentence,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Back to Puzzle واپس کھیلیں'),
            ),
          ],
        ),
      ),
    );
  }

  void _checkLevelCompletion() {
    if (widget.gameEngine.isLevelCompleted && !_hasShownCompletionModal) {
      _hasShownCompletionModal = true;
      final lvl = widget.gameEngine.currentLevel!;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LevelSummaryVocabularyScreen(
              level: lvl,
              gameEngine: widget.gameEngine,
              levelRepository: widget.levelRepository,
              wordRepository: widget.wordRepository,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.gameEngine,
      builder: (context, _) {
        final engine = widget.gameEngine;
        final level = engine.currentLevel;

        if (level == null) {
          return const Scaffold(body: Center(child: Text('No active level')));
        }

        _checkLevelCompletion();

        return Scaffold(
          body: SchoolRoomBackground(
            classId: level.classId,
            child: SafeArea(
              child: Column(
                children: [
                  // Header Bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Column(
                          children: [
                            Text(
                              'Level ${level.levelNumber}: ${level.roomName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              level.className,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.lightbulb_outline_rounded,
                              color: AppColors.goldCoin, size: 28),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => HintDialog(
                                currentCoins: engine.progress.coins,
                                onSelectHint: (type) {
                                  engine.useHint(type);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Score Board
                  ScoreBoard(
                    score: engine.progress.totalScore,
                    coins: engine.progress.coins,
                    currentStreak: engine.progress.currentStreak,
                    foundCount: engine.foundWords.length,
                    targetCount: level.targetWords,
                  ),

                  // Found Words Grid
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          FoundWordsGrid(
                            validAnswers: level.validAnswers,
                            foundWords: engine.foundWords,
                            onWordTap: _onWordFoundTap,
                          ),
                          const SizedBox(height: 6),
                          // Live feedback banner
                          if (engine.statusFeedback.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: engine.isLastActionSuccess
                                    ? AppColors.successGreen.withOpacity(0.12)
                                    : AppColors.errorRed.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: engine.isLastActionSuccess
                                      ? AppColors.successGreen
                                      : AppColors.errorRed,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    engine.statusFeedback,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: engine.isLastActionSuccess
                                          ? AppColors.successGreen
                                          : AppColors.errorRed,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  if (engine.statusFeedbackUrdu.isNotEmpty)
                                    Text(
                                      engine.statusFeedbackUrdu,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: engine.isLastActionSuccess
                                            ? AppColors.successGreen
                                            : AppColors.errorRed,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Swipe-to-Connect Letter Puzzle Wheel
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SwipeWordCanvas(
                      letters: engine.displayLetters,
                      onWordSubmitted: (word) {
                        engine.submitDirectWord(word);
                      },
                      onShuffle: () {
                        engine.shuffleLetters();
                      },
                      size: 260,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
