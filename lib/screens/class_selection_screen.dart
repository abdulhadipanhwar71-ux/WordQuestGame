import 'package:flutter/material.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../models/school_class.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';
import 'level_selection_screen.dart';

class ClassSelectionScreen extends StatelessWidget {
  final GameEngine gameEngine;
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final StorageService storageService;

  const ClassSelectionScreen({
    Key? key,
    required this.gameEngine,
    required this.levelRepository,
    required this.wordRepository,
    required this.storageService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = storageService.progress;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Word School Classes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: SchoolClass.all.length,
        itemBuilder: (context, index) {
          final schoolClass = SchoolClass.all[index];
          final classLevels = levelRepository.getLevelsForClass(schoolClass.id);

          // Check if class is unlocked (first class always unlocked, or start level is unlocked)
          final isUnlocked = schoolClass.startLevel == 1 ||
              progress.isLevelUnlocked(schoolClass.startLevel);

          int completedInClass = 0;
          int starsInClass = 0;
          for (final lvl in classLevels) {
            if (progress.isLevelCompleted(lvl.id)) {
              completedInClass++;
              starsInClass += progress.getStarsForLevel(lvl.id);
            }
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: isUnlocked
                    ? schoolClass.themeColors
                    : [Colors.grey.shade400, Colors.grey.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: isUnlocked
                      ? schoolClass.themeColors.first.withOpacity(0.3)
                      : Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: isUnlocked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LevelSelectionScreen(
                              schoolClass: schoolClass,
                              gameEngine: gameEngine,
                              levelRepository: levelRepository,
                              wordRepository: wordRepository,
                              storageService: storageService,
                            ),
                          ),
                        );
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Complete previous levels to unlock ${schoolClass.name}!',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isUnlocked ? schoolClass.icon : Icons.lock_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  schoolClass.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isUnlocked)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star_rounded,
                                            color: AppColors.goldStar,
                                            size: 16),
                                        const SizedBox(width: 2),
                                        Text(
                                          '$starsInClass/${classLevels.length * 3}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              schoolClass.titleUrdu,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Room: ${schoolClass.roomName}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              isUnlocked
                                  ? '$completedInClass of ${classLevels.length} Levels Finished'
                                  : 'Locked • Requires Level ${schoolClass.startLevel - 1}',
                              style: TextStyle(
                                color: isUnlocked
                                    ? Colors.white.withOpacity(0.9)
                                    : Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
