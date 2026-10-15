# Word Quest: Word School (لفظی درسگاہ)

**Word Quest: Word School** is a complete, polished, 100% offline educational Android word puzzle game built with Flutter and Dart. Players construct valid English words from curated letter sets, earn coins and stars, unlock progressive school rooms (from Kindergarten to the Grand Master Auditorium), and learn verified Urdu meanings for all discovered words.

---

## 🎯 Key Highlights

- **100% Offline Capability**: Runs entirely without internet or mobile data. All 30 levels, 159 approved words, Urdu translations, and achievements are bundled locally.
- **Curated 30 Levels across 5 School Classes**:
  - **Class 1: Beginner** (Classroom 101) — 3-letter foundations.
  - **Class 2: Explorer** (School Library) — 3 & 4-letter vocabulary.
  - **Class 3: Word Builder** (Science Lab) — 4-letter compounds.
  - **Class 4: Scholar** (Language Lab) — 4 & 5-letter puzzles.
  - **Class 5: Master** (Grand Auditorium) — 5 & 6-letter masterworks.
- **English-to-Urdu Learning**: Every accepted word features a verified Urdu translation and pronunciation/definition guide.
- **Fair Gameplay & Strict Validation**:
  - Enforces letter counts (e.g. puzzle with one 'A' cannot produce words with two 'A's).
  - Rejects words below level minimum length.
  - Case-insensitive duplicate detection.
  - Rejects unpermitted letter combinations.
- **Central Scoring Engine**:
  - 2-letter word: 2 points
  - 3-letter word: 5 points
  - 4-letter word: 10 points
  - 5-letter word: 15 points
  - 6+ letter word: 20 points
  - Level completion bonus: 20 points (awarded once)
- **Real Hint System**:
  - Reveal First Letter (10 coins)
  - Reveal Word Length (5 coins)
  - Reveal Urdu Meaning Clue (15 coins)
- **10 Complete Screens**:
  1. Splash Screen
  2. Home Screen
  3. Class Selection Screen
  4. Level Selection Screen
  5. Gameplay Screen
  6. Level Completion Screen
  7. Achievements Screen
  8. Word Learning Panel Screen
  9. Settings Screen
  10. Help & About Screen
- **Two Game Modes**:
  - Relaxed School Quest (Default, no countdown pressure)
  - 60-Second Speed Challenge (Bonus coin multiplier)

---

## 📂 Project Directory Structure

```text
D:\WordQuestGame\
├── android\                     # Android native project configuration
├── assets\
│   └── data\
│       ├── levels.json          # 30 curated playable levels
│       ├── dictionary.json      # Offline approved vocabulary
│       ├── urdu_meanings.json   # 100% verified Urdu translations
│       └── achievements.json    # Unlockable achievements
├── docs\
│   ├── PROJECT_PLAN.md          # Project milestones and roadmap
│   ├── GAME_DESIGN.md           # Game mechanics and theme specifications
│   ├── ARCHITECTURE.md          # Architecture and state management details
│   ├── PROGRESS.md              # Live implementation log
│   ├── TEST_REPORT.md           # Comprehensive test results
│   ├── BUILD_AND_INSTALL.md     # APK build and phone installation guide
│   └── MORNING_CHECKLIST.md     # Morning review checklist for user
├── lib\
│   ├── main.dart                # App entry point
│   ├── app\                     # App configuration & MaterialApp
│   ├── models\                  # Data models (Level, Progress, Achievement, etc.)
│   ├── data\                    # Repositories & ScoringConfig
│   ├── services\                # StorageService & AudioService
│   ├── game\                    # WordValidator, GameEngine, HintSystem, TimedEngine
│   ├── screens\                 # 10 fully functional game screens
│   ├── widgets\                 # Reusable game UI components
│   └── theme\                   # School color palette & typography
├── test\                        # Automated test suites
├── pubspec.yaml                 # Flutter configuration & asset declarations
└── generate_data.py             # Data verification & generator tool
```

---

## 🚀 Running Tests & Verification

Run the full automated test suite verifying all 15 core game logic specifications:

```powershell
cd D:\WordQuestGame
python test/run_all_automated_tests.py
```

Result: **25 Passed, 0 Failed**.

---

## 📱 Building the Android APK

When Flutter and the Android SDK are installed:

```powershell
cd D:\WordQuestGame
flutter pub get
flutter build apk --debug
```

The APK will be generated at:
`build/app/outputs/flutter-apk/app-debug.apk`
