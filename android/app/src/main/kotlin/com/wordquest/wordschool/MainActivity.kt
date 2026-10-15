package com.wordquest.wordschool

import android.content.res.AssetFileDescriptor
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.SoundPool
import android.media.ToneGenerator
import android.os.Build
import android.speech.tts.TextToSpeech
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Locale

class MainActivity: FlutterActivity(), TextToSpeech.OnInitListener {
    private val CHANNEL = "com.wordquest.wordschool/audio"
    private var tts: TextToSpeech? = null
    private var ttsReady = false
    private var toneGen: ToneGenerator? = null
    private var soundPool: SoundPool? = null
    private val soundMap = HashMap<String, Int>()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        initAudio()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playSound" -> {
                    val sound = call.argument<String>("type") ?: "tap"
                    playAudioEffect(sound)
                    result.success(true)
                }
                "speakWord" -> {
                    val word = call.argument<String>("word") ?: ""
                    speak(word)
                    result.success(true)
                }
                "stopSpeech" -> {
                    tts?.stop()
                    result.success(true)
                }
                "isTtsAvailable" -> {
                    result.success(ttsReady)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun initAudio() {
        try {
            toneGen = ToneGenerator(AudioManager.STREAM_MUSIC, 95)
        } catch (e: Exception) {
            toneGen = null
        }

        try {
            tts = TextToSpeech(applicationContext, this)
        } catch (e: Exception) {
            tts = null
        }

        try {
            val audioAttributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_GAME)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()

            soundPool = SoundPool.Builder()
                .setMaxStreams(6)
                .setAudioAttributes(audioAttributes)
                .build()

            val soundNames = arrayOf("tap", "connect", "correct", "error", "hint", "coin", "level_complete", "achievement")
            for (name in soundNames) {
                try {
                    // Flutter bundles assets under flutter_assets/assets/audio/
                    val afd: AssetFileDescriptor = assets.openFd("flutter_assets/assets/audio/$name.wav")
                    val soundId = soundPool?.load(afd, 1) ?: -1
                    if (soundId != -1) {
                        soundMap[name] = soundId
                    }
                } catch (e: Exception) {
                    // Asset loading fallback to toneGen
                }
            }
        } catch (e: Exception) {
            soundPool = null
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts?.setLanguage(Locale.US)
            ttsReady = (result != TextToSpeech.LANG_MISSING_DATA && result != TextToSpeech.LANG_NOT_SUPPORTED)
            tts?.setSpeechRate(0.85f)
        } else {
            ttsReady = false
        }
    }

    private fun speak(text: String) {
        if (text.isBlank()) return
        try {
            if (ttsReady && tts != null) {
                tts?.speak(text, TextToSpeech.QUEUE_FLUSH, null, "WordQuest_$text")
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun playAudioEffect(type: String) {
        var played = false
        val soundId = soundMap[type]
        if (soundId != null && soundPool != null) {
            val streamId = soundPool?.play(soundId, 1.0f, 1.0f, 1, 0, 1.0f) ?: 0
            if (streamId != 0) {
                played = true
            }
        }

        if (!played && toneGen != null) {
            try {
                when (type) {
                    "tap" -> toneGen?.startTone(ToneGenerator.TONE_PROP_BEEP, 35)
                    "connect" -> toneGen?.startTone(ToneGenerator.TONE_PROP_ACK, 45)
                    "correct" -> toneGen?.startTone(ToneGenerator.TONE_CDMA_ALERT_NETWORK_LITE, 120)
                    "error" -> toneGen?.startTone(ToneGenerator.TONE_PROP_NACK, 120)
                    "hint" -> toneGen?.startTone(ToneGenerator.TONE_PROP_PROMPT, 90)
                    "coin" -> toneGen?.startTone(ToneGenerator.TONE_PROP_ACK, 70)
                    "level_complete" -> toneGen?.startTone(ToneGenerator.TONE_CDMA_CONFIRM, 250)
                    "achievement" -> toneGen?.startTone(ToneGenerator.TONE_CDMA_ALERT_INCALL_LITE, 200)
                    else -> toneGen?.startTone(ToneGenerator.TONE_PROP_BEEP, 30)
                }
            } catch (e: Exception) {
                // Ignore tone generator errors
            }
        }
    }

    override fun onDestroy() {
        try {
            tts?.stop()
            tts?.shutdown()
            toneGen?.release()
            soundPool?.release()
        } catch (e: Exception) {
            // Ignore cleanup exceptions
        }
        super.onDestroy()
    }
}
