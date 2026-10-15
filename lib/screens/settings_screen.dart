import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final StorageService storageService;

  const SettingsScreen({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _sound;
  late bool _haptics;
  late bool _pronunciation;
  late bool _animations;

  @override
  void initState() {
    super.initState();
    _sound = widget.storageService.progress.soundEnabled;
    _haptics = widget.storageService.progress.hapticsEnabled;
    _pronunciation = widget.storageService.progress.pronunciationEnabled;
    _animations = widget.storageService.progress.animationsEnabled;
  }

  void _toggleSound(bool val) {
    setState(() => _sound = val);
    AudioService.soundEnabled = val;
    widget.storageService.progress.soundEnabled = val;
    widget.storageService.saveProgress(widget.storageService.progress);
  }

  void _toggleHaptics(bool val) {
    setState(() => _haptics = val);
    AudioService.hapticsEnabled = val;
    widget.storageService.progress.hapticsEnabled = val;
    widget.storageService.saveProgress(widget.storageService.progress);
  }

  void _togglePronunciation(bool val) {
    setState(() => _pronunciation = val);
    AudioService.pronunciationEnabled = val;
    widget.storageService.progress.pronunciationEnabled = val;
    widget.storageService.saveProgress(widget.storageService.progress);
  }

  void _toggleAnimations(bool val) {
    setState(() => _animations = val);
    widget.storageService.progress.animationsEnabled = val;
    widget.storageService.saveProgress(widget.storageService.progress);
  }

  Future<void> _confirmResetProgress() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset All Progress?'),
        content: const Text(
          'This will reset your score, coins, stars, unlocked levels, and achievements to beginning. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () => Navigator.pop(ctx, true),
            child:
                const Text('Reset All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.storageService.resetProgress();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Progress has been reset.')),
        );
        setState(() {
          _sound = widget.storageService.progress.soundEnabled;
          _haptics = widget.storageService.progress.hapticsEnabled;
          _pronunciation = widget.storageService.progress.pronunciationEnabled;
          _animations = widget.storageService.progress.animationsEnabled;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Settings (ترتیبات)'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up_rounded,
                      color: AppColors.primaryBlue),
                  title: const Text('Sound Effects (آوازیں)'),
                  subtitle: const Text(
                      'Play audio on taps, word connections, and level completion'),
                  value: _sound,
                  onChanged: _toggleSound,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.record_voice_over_rounded,
                      color: AppColors.primaryBlue),
                  title: const Text('English Pronunciation (انگریزی تلفظ)'),
                  subtitle: const Text(
                      'Voice pronunciation on word learning and victory screens'),
                  value: _pronunciation,
                  onChanged: _togglePronunciation,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.vibration_rounded,
                      color: AppColors.primaryBlue),
                  title: const Text('Haptic Vibration (تھرٹھراہٹ)'),
                  subtitle: const Text(
                      'Vibrate gently on tile selection and submissions'),
                  value: _haptics,
                  onChanged: _toggleHaptics,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.celebration_rounded,
                      color: AppColors.goldCoin),
                  title: const Text('Celebration Animations (پھولوں کی تقریب)'),
                  subtitle: const Text(
                      'Falling petals celebration on level completion'),
                  value: _animations,
                  onChanged: _toggleAnimations,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.wifi_off_rounded,
                      color: AppColors.successGreen),
                  title: const Text('Offline Play Status'),
                  subtitle: const Text(
                      '100% Offline • No internet connection required'),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.successGreen.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Ready',
                      style: TextStyle(
                          color: AppColors.successGreen,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.refresh_rounded,
                      color: AppColors.errorRed),
                  title: const Text('Reset Progress (دوبارہ شروع کریں)'),
                  subtitle:
                      const Text('Clear all saved stars, coins, and levels'),
                  onTap: _confirmResetProgress,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Word Quest: Word School v1.0.0 (Offline Edition)',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
