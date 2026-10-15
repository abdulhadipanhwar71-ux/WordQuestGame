import 'package:flutter/material.dart';
import '../data/achievement_repository.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';

class AchievementsScreen extends StatelessWidget {
  final AchievementRepository achievementRepository;
  final StorageService storageService;

  const AchievementsScreen({
    Key? key,
    required this.achievementRepository,
    required this.storageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = storageService.progress;
    final achievements = achievementRepository.achievements;
    final unlockedCount = achievements
        .where((a) => progress.unlockedAchievementIds.contains(a.id))
        .length;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Achievements (کامیابیاں)'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8F00), Color(0xFFFF6F00)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.military_tech_rounded,
                    size: 48, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$unlockedCount of ${achievements.length} Unlocked',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Earn extra coins and honor badges as you play!',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final ach = achievements[index];
                final isUnlocked =
                    progress.unlockedAchievementIds.contains(ach.id);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color:
                          isUnlocked ? AppColors.goldCoin : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUnlocked
                                ? AppColors.goldCoin.withOpacity(0.15)
                                : Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isUnlocked
                                ? Icons.workspace_premium_rounded
                                : Icons.lock_outline_rounded,
                            color:
                                isUnlocked ? AppColors.goldCoin : Colors.grey,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ach.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: isUnlocked
                                          ? AppColors.textDark
                                          : Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.goldCoin.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.monetization_on,
                                            size: 14,
                                            color: AppColors.goldCoin),
                                        const SizedBox(width: 2),
                                        Text(
                                          '+${ach.rewardCoins}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                ach.titleUrdu,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isUnlocked
                                      ? AppColors.primaryBlue
                                      : Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                ach.description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isUnlocked
                                      ? Colors.black87
                                      : Colors.grey.shade500,
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
        ],
      ),
    );
  }
}
