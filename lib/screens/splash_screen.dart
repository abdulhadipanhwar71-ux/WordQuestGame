import 'package:flutter/material.dart';
import '../data/achievement_repository.dart';
import '../data/level_repository.dart';
import '../data/word_repository.dart';
import '../game/game_engine.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final LevelRepository levelRepository;
  final WordRepository wordRepository;
  final AchievementRepository achievementRepository;
  final StorageService storageService;
  final GameEngine gameEngine;

  const SplashScreen({
    Key? key,
    required this.levelRepository,
    required this.wordRepository,
    required this.achievementRepository,
    required this.storageService,
    required this.gameEngine,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _status = 'Loading School Library...';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      setState(() => _status = 'Loading game progress...');
      await widget.storageService.init();

      setState(() => _status = 'Loading 30 school levels...');
      await widget.levelRepository.loadLevels();

      setState(() => _status = 'Loading Urdu dictionary...');
      await widget.wordRepository.load();

      setState(() => _status = 'Loading achievements...');
      await widget.achievementRepository.loadAchievements();

      await Future.delayed(const Duration(milliseconds: 600));

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              gameEngine: widget.gameEngine,
              levelRepository: widget.levelRepository,
              wordRepository: widget.wordRepository,
              achievementRepository: widget.achievementRepository,
              storageService: widget.storageService,
            ),
          ),
        );
      }
    } catch (e) {
      setState(() => _status = 'Error initializing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlueDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.school_rounded,
                size: 80,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'WORD QUEST',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.goldCoin,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'WORD SCHOOL  •  لفظی درسگاہ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _status,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
