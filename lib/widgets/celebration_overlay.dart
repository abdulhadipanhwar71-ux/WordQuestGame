import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CelebrationOverlay extends StatelessWidget {
  final int stars;
  final int coins;
  final int bonusPoints;
  final VoidCallback onNextLevel;
  final VoidCallback onReviewWords;
  final VoidCallback onReplay;

  const CelebrationOverlay({
    Key? key,
    required this.stars,
    required this.coins,
    required this.bonusPoints,
    required this.onNextLevel,
    required this.onReviewWords,
    required this.onReplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🎉 LEVEL COMPLETED! 🎉',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryBlueDark,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'کامیابی! لیول مکمل ہو گیا',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.successGreen,
              ),
            ),
            const SizedBox(height: 20),
            // Stars row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isAwarded = index < stars;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.star_rounded,
                    size: 46,
                    color:
                        isAwarded ? AppColors.goldStar : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            // Reward Cards
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.monetization_on_rounded,
                          color: AppColors.goldCoin, size: 28),
                      const SizedBox(height: 4),
                      Text('+$coins Coins',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.stars_rounded,
                          color: AppColors.goldStar, size: 28),
                      const SizedBox(height: 4),
                      Text('+$bonusPoints Pts',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Buttons
            ElevatedButton(
              onPressed: onNextLevel,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Next Level اگلا درجہ',
                  style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReviewWords,
                    icon: const Icon(Icons.translate_rounded, size: 18),
                    label: const Text('Review Words'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReplay,
                    icon: const Icon(Icons.replay_rounded, size: 18),
                    label: const Text('Play Again'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
