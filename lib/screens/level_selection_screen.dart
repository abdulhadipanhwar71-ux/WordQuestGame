import 'package:flutter/material.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../models/school_class.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';
import 'gameplay_screen.dart';

class LevelSelectionScreen extends StatefulWidget {
  final SchoolClass schoolClass;
  final GameEngine gameEngine;
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final StorageService storageService;

  const LevelSelectionScreen({
    Key? key,
    required this.schoolClass,
    required this.gameEngine,
    required this.levelRepository,
    required this.wordRepository,
    required this.storageService,
  }) : super(key: key);

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final levels =
        widget.levelRepository.getLevelsForClass(widget.schoolClass.id);
    final progress = widget.storageService.progress;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('${widget.schoolClass.name} Levels'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Class Banner
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.schoolClass.themeColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Room: ${widget.schoolClass.roomName}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      widget.schoolClass.titleUrdu,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.schoolClass.description,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
              itemCount: levels.length,
              itemBuilder: (context, index) {
                final level = levels[index];
                final isUnlocked = progress.isLevelUnlocked(level.levelNumber);
                final stars = progress.getStarsForLevel(level.id);

                return Material(
                  color: isUnlocked ? Colors.white : Colors.grey.shade200,
                  elevation: isUnlocked ? 3 : 0,
                  borderRadius: BorderRadius.circular(16),
                  shadowColor: Colors.black12,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: isUnlocked
                        ? () {
                            widget.gameEngine.startLevel(level);
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
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Complete previous levels to unlock!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!isUnlocked)
                            const Icon(Icons.lock_rounded,
                                color: Colors.grey, size: 28)
                          else
                            Text(
                              '${level.levelNumber}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: AppColors.primaryBlueDark,
                              ),
                            ),
                          const SizedBox(height: 6),
                          if (isUnlocked)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (starIdx) {
                                return Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: starIdx < stars
                                      ? AppColors.goldStar
                                      : Colors.grey.shade300,
                                );
                              }),
                            )
                          else
                            const Text(
                              'Locked',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          const SizedBox(height: 6),
                          // Letters hint
                          Text(
                            level.letters.join(' '),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isUnlocked
                                  ? Colors.black54
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
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
