import 'package:flutter/material.dart';
import '../data/scoring_config.dart';
import '../theme/app_colors.dart';

class HelpAboutScreen extends StatelessWidget {
  const HelpAboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Help & About (کھیل کی رہنمائی)'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            title: '🎮 How to Play (کیسے کھیلیں)',
            content:
                '1. Look at the letter tiles provided in each classroom level.\n'
                '2. Tap the tiles in order to spell a valid English word.\n'
                '3. Tap "Submit" to validate your word.\n'
                '4. Each correct word awards points and reveals its Urdu meaning.\n'
                '5. Meet the target number of words to unlock the next classroom level!',
          ),
          const SizedBox(height: 12),
          _buildCard(
            title: '🏆 Scoring Rules (پوائنٹس کے اصول)',
            content:
                '• 2-letter word: ${ScoringConfig.pointsForTwoLetterWord} points (where permitted)\n'
                '• 3-letter word: ${ScoringConfig.pointsForThreeLetterWord} points\n'
                '• 4-letter word: ${ScoringConfig.pointsForFourLetterWord} points\n'
                '• 5-letter word: ${ScoringConfig.pointsForFiveLetterWord} points\n'
                '• 6+ letter word: ${ScoringConfig.pointsForSixOrMoreLetterWord} points\n'
                '• Completing a level: ${ScoringConfig.levelCompletionBonusPoints} Bonus Points (awarded once)',
          ),
          const SizedBox(height: 12),
          _buildCard(
            title: '💡 School Hints (اشارے کے اصول)',
            content:
                '• Reveal First Letter: ${ScoringConfig.costRevealFirstLetter} Coins\n'
                '• Reveal Word Length: ${ScoringConfig.costRevealWordLength} Coins\n'
                '• Reveal Urdu Translation: ${ScoringConfig.costRevealUrduMeaning} Coins\n'
                '• Sentence Clue: ${ScoringConfig.costRevealSentenceClue} Coins\n'
                'Hints will only uncover words you haven\'t discovered yet.',
          ),
          const SizedBox(height: 12),
          _buildCard(
            title: '📚 5 School Classes & 50 Levels',
            content: '• Class 1: Beginner (Classroom 101) — Levels 1–10\n'
                '• Class 2: Explorer (School Library) — Levels 11–20\n'
                '• Class 3: Word Builder (Science Lab) — Levels 21–30\n'
                '• Class 4: Scholar (Language Lab) — Levels 31–40\n'
                '• Class 5: Master (Grand Auditorium) — Levels 41–50',
          ),
          const SizedBox(height: 12),
          _buildCard(
            title: '🛡️ Offline Guarantee',
            content:
                'Word Quest: Word School is 100% offline. All levels, dictionary words, achievements, and Urdu translations are bundled locally in the app. No internet or data required!',
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Word Quest: Word School\nDeveloped with Flutter & Dart',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required String content}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlueDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                  fontSize: 14, height: 1.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
