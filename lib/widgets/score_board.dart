import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScoreBoard extends StatelessWidget {
  final int score;
  final int coins;
  final int currentStreak;
  final int foundCount;
  final int targetCount;

  const ScoreBoard({
    Key? key,
    required this.score,
    required this.coins,
    required this.currentStreak,
    required this.foundCount,
    required this.targetCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Score
          Row(
            children: [
              const Icon(Icons.stars_rounded,
                  color: AppColors.goldStar, size: 22),
              const SizedBox(width: 4),
              Text(
                '$score pts',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          // Streak
          if (currentStreak > 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded,
                      color: Colors.deepOrange, size: 16),
                  Text(
                    ' $currentStreak streak',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          // Coins
          Row(
            children: [
              const Icon(Icons.monetization_on_rounded,
                  color: AppColors.goldCoin, size: 22),
              const SizedBox(width: 4),
              Text(
                '$coins',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          // Level progress
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$foundCount / $targetCount',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.primaryBlueDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
