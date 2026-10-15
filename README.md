# Word Quest: Word School (لفظی درسگاہ) 🎓✨

---

### 📲 [📥 DOWNLOAD WORD QUEST APK (Click Here / یہاں کلک کر کے ڈاؤنلوڈ کریں)](https://files.catbox.moe/etzlrq.apk) 🚀

> **📱 Direct Mobile Download:** Tap the link above to immediately download `WordQuest.apk` (97 MB) to your Android phone!  
> **🌐 Mirror 2 (Backup):** [https://tmpfiles.org/dl/wgAnZyTeEKKw/wordquest.apk](https://tmpfiles.org/dl/wgAnZyTeEKKw/wordquest.apk)

---

## 🎯 Key Highlights

- **100% Offline Capability**: Runs entirely without internet or mobile data. All 50 levels, 336 words, Urdu translations, audio sound effects, and achievements are bundled locally.
- **Swipe-to-Connect Letter Puzzle**:
  - Circular letter pad layout supporting 3 to 6 letter tiles.
  - Smooth continuous line rendering with vibrant golden core and glowing borders.
  - Release finger to submit formed words instantly.
  - Center shuffle button to rearrange letters with audio feedback.
- **50 Curated Levels across 5 School Classes (10 Levels Each)**:
  - **Class 1: Beginner** (Classroom 101) — Levels 1–10 (3 to 4-letter words).
  - **Class 2: Explorer** (School Library) — Levels 11–20 (4-letter puzzles).
  - **Class 3: Word Builder** (Science Lab) — Levels 21–30 (4 & 5-letter compounds).
  - **Class 4: Scholar** (Language Lab) — Levels 31–40 (5-letter vocabulary).
  - **Class 5: Master** (Grand Auditorium) — Levels 41–50 (5 & 6-letter anagrams).
- **English-to-Urdu Learning & Post-Level Vocabulary Screen**:
  - Every word has a verified Urdu translation and pronunciation helper.
  - Short English example sentence for each word.
  - Urdu translation of the example sentence.
  - Voice pronunciation button on every word card.
  - Explicit "Continue" button; never forces auto-skip.
- **Offline Audio & Sound Effects**:
  - Bundled 16-bit PCM sound effects for tile taps, letter connections, correct word chimes, error buzzers, hint shimmers, coins, and victory fanfare.
  - Android native Text-To-Speech (TTS) integration for natural English voice pronunciation.
- **Celebration Falling Petals Animation**:
  - Lightweight custom particle animation of blossoming flower petals drifting down on level victory.
  - Can be toggled on/off in Settings.
- **4 Hint Modes**:
  - Reveal First Letter (10 coins)
  - Reveal Word Length (5 coins)
  - Reveal Urdu Meaning Clue (15 coins)
  - Sentence Clue with blanked word (15 coins)
- **11 Complete Screens**:
  1. Splash Screen
  2. Home Screen
  3. Class Selection Screen
  4. Level Selection Screen
  5. Gameplay Screen (Swipe Canvas)
  6. Level Summary Vocabulary Screen
  7. Level Completion Screen
  8. Achievements Screen
  9. Word Learning Review Panel
  10. Settings Screen (Audio, Vibration, Pronunciation, Animation toggles)
  11. Help & About Screen

---

## 📂 Project Directory Structure

```text
D:\WordQuestGame\
├── android\                     # Android native project & Gradle wrapper
│   └── app\src\main\kotlin\     # MainActivity.kt (ToneGen, SoundPool, TTS channel)
├── assets\
│   ├── audio\                   # Bundled offline PCM WAV sound effects
│   ├── data\
│   │   ├── levels.json          # 50 curated playable levels
│   │   ├── dictionary.json      # Offline approved vocabulary
│   │   ├── urdu_meanings.json   # 338 verified Urdu translations
│   │   ├── word_details.json    # 336 example sentences & Urdu translations
│   │   └── achievements.json    # Unlockable achievements
│   └── images\
├── lib\
│   ├── app\                     # App widget and routes
│   ├── data\                    # Repositories (Levels, Words, Achievements)
│   ├── game\                    # GameEngine, HintSystem, ScoringEngine, Validator
│   ├── models\                  # Level, SchoolClass, WordEntry, PlayerProgress
│   ├── screens\                 # All 11 UI game screens
│   ├── services\                # AudioService (TTS + Sound effects), StorageService
│   ├── theme\                   # AppColors, AppTheme
│   └── widgets\                 # SwipeWordCanvas, FallingPetalsOverlay, etc.
└── test\                        # 18 Flutter unit tests & automated test suite
```

---

## 🛠️ Build and Verification Instructions

```bash
# 1. Analyze code quality (0 errors, 0 warnings)
flutter analyze

# 2. Run automated test suite
flutter test

# 3. Build Android debug APK
flutter build apk --debug
```

APK Output: `build/app/outputs/flutter-apk/app-debug.apk` (~97.4 MB).
