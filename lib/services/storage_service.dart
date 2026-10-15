import 'package:shared_preferences/shared_preferences.dart';
import '../models/player_progress.dart';

class StorageService {
  static const String _keyPlayerProgress = 'word_quest_player_progress_v1';
  SharedPreferences? _prefs;
  PlayerProgress _progress = PlayerProgress();

  PlayerProgress get progress => _progress;

  Future<void> init({SharedPreferences? mockPrefs}) async {
    try {
      _prefs = mockPrefs ?? await SharedPreferences.getInstance();
      final jsonString = _prefs?.getString(_keyPlayerProgress);
      if (jsonString != null && jsonString.isNotEmpty) {
        _progress = PlayerProgress.fromJson(jsonString);
      } else {
        _progress = PlayerProgress();
      }
    } catch (_) {
      // Graceful fallback to default in-memory progress
      _progress = PlayerProgress();
    }
  }

  Future<bool> saveProgress(PlayerProgress progress) async {
    _progress = progress;
    try {
      if (_prefs != null) {
        return await _prefs!.setString(_keyPlayerProgress, progress.toJson());
      }
    } catch (_) {}
    return true;
  }

  Future<void> resetProgress() async {
    _progress = PlayerProgress();
    try {
      if (_prefs != null) {
        await _prefs!.remove(_keyPlayerProgress);
      }
    } catch (_) {}
  }
}
