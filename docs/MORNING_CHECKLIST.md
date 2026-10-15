# Morning Verification Checklist for User

Use this quick checklist to inspect and verify the project:

### 1. Project Directory Verification
- [ ] Open Windows Explorer and navigate to `D:\WordQuestGame`.
- [ ] Confirm the presence of `lib/`, `assets/`, `docs/`, `android/`, `test/`, and `pubspec.yaml`.

### 2. Verify Automated Tests (Passing 100%)
- [ ] Open PowerShell.
- [ ] Run:
  ```powershell
  cd D:\WordQuestGame
  python test/run_all_automated_tests.py
  ```
- [ ] Confirm that all 25 automated tests pass with 0 failures.

### 3. Inspect Offline Game Data
- [ ] Open `D:\WordQuestGame\assets\data\levels.json` and review the 30 distinct levels across the 5 School Classes.
- [ ] Open `D:\WordQuestGame\assets\data\urdu_meanings.json` and review the 159 verified Urdu translations.
- [ ] Open `D:\WordQuestGame\assets\data\achievements.json` and review the 6 unlockable achievements.

### 4. Inspect the 10 Game Screens
- [ ] `lib/screens/splash_screen.dart` — App boot & asset preload.
- [ ] `lib/screens/home_screen.dart` — School hub, play button, timed mode, stat bar.
- [ ] `lib/screens/class_selection_screen.dart` — 5 School Classes (Classroom, Library, Science Lab, Language Lab, Master Auditorium).
- [ ] `lib/screens/level_selection_screen.dart` — Level selection grid with stars & lock state.
- [ ] `lib/screens/gameplay_screen.dart` — Core letter tile spelling, live Urdu translation, score board.
- [ ] `lib/screens/level_completion_screen.dart` — Level clear summary, stars, bonus coins.
- [ ] `lib/screens/achievements_screen.dart` — Honor badges & achievements list.
- [ ] `lib/screens/word_learning_panel_screen.dart` — Searchable English-Urdu vocabulary dictionary.
- [ ] `lib/screens/settings_screen.dart` — Sound, haptics, reset progress dialog.
- [ ] `lib/screens/help_about_screen.dart` — How to play, scoring rules, offline guarantee.

### 5. Building the Android APK
- [ ] When ready to test on a physical phone, ensure Flutter is installed, then execute:
  ```powershell
  cd D:\WordQuestGame
  flutter pub get
  flutter build apk --debug
  ```
- [ ] Copy the generated `build/app/outputs/flutter-apk/app-debug.apk` to your Android device and play!
