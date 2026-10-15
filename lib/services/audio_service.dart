import 'package:flutter/services.dart';

class AudioService {
  static const MethodChannel _channel =
      MethodChannel('com.wordquest.wordschool/audio');

  static bool soundEnabled = true;
  static bool hapticsEnabled = true;
  static bool pronunciationEnabled = true;

  static Future<void> _invokeNativeAudio(String type) async {
    if (!soundEnabled) return;
    try {
      await _channel.invokeMethod('playSound', {'type': type});
    } catch (_) {
      // Platform channel not available on non-Android or during tests
    }
  }

  static void playTileTap() {
    if (soundEnabled) {
      _invokeNativeAudio('tap');
      SystemSound.play(SystemSoundType.click);
    }
    if (hapticsEnabled) {
      HapticFeedback.selectionClick();
    }
  }

  static void playTileConnect() {
    if (soundEnabled) {
      _invokeNativeAudio('connect');
      SystemSound.play(SystemSoundType.click);
    }
    if (hapticsEnabled) {
      HapticFeedback.selectionClick();
    }
  }

  static void playWordSuccess() {
    if (soundEnabled) {
      _invokeNativeAudio('correct');
      SystemSound.play(SystemSoundType.alert);
    }
    if (hapticsEnabled) {
      HapticFeedback.mediumImpact();
    }
  }

  static void playWordError() {
    if (soundEnabled) {
      _invokeNativeAudio('error');
    }
    if (hapticsEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  static void playHint() {
    if (soundEnabled) {
      _invokeNativeAudio('hint');
      SystemSound.play(SystemSoundType.click);
    }
    if (hapticsEnabled) {
      HapticFeedback.lightImpact();
    }
  }

  static void playCoin() {
    if (soundEnabled) {
      _invokeNativeAudio('coin');
      SystemSound.play(SystemSoundType.click);
    }
    if (hapticsEnabled) {
      HapticFeedback.selectionClick();
    }
  }

  static void playLevelComplete() {
    if (soundEnabled) {
      _invokeNativeAudio('level_complete');
      SystemSound.play(SystemSoundType.alert);
    }
    if (hapticsEnabled) {
      HapticFeedback.vibrate();
    }
  }

  static void playAchievement() {
    if (soundEnabled) {
      _invokeNativeAudio('achievement');
      SystemSound.play(SystemSoundType.alert);
    }
    if (hapticsEnabled) {
      HapticFeedback.vibrate();
    }
  }

  static Future<void> speakWord(String word) async {
    if (!pronunciationEnabled || word.trim().isEmpty) return;
    try {
      await _channel.invokeMethod('speakWord', {'word': word.trim()});
    } catch (_) {
      // Fallback
    }
  }

  static Future<void> stopSpeech() async {
    try {
      await _channel.invokeMethod('stopSpeech');
    } catch (_) {
      // Fallback
    }
  }
}
