# System Architecture: Word Quest - Word School

## 1. Architectural Pattern
Word Quest utilizes a clean, layered architecture with reactive state management built on Flutter's built-in `ChangeNotifier` / `AnimatedBuilder` pattern. This guarantees zero runtime bloat and ensures high performance across all mobile devices.

```text
[ UI Presentation Layer ]
       │
       ▼
[ Game State Layer (GameEngine / TimedChallengeEngine) ]
       │
       ▼
[ Core Validation & Scoring Layer (WordValidator, ScoringEngine, HintSystem) ]
       │
       ▼
[ Data & Repository Layer (LevelRepository, WordRepository, AchievementRepository) ]
       │
       ▼
[ Persistence & Offline Storage Layer (StorageService / SharedPreferences) ]
```

## 2. Component Responsibilities

### `lib/models/`
- `level.dart`: Encapsulates puzzle metadata, letter sets, valid answer list, target words, and reward configuration.
- `word_entry.dart`: Represents word definitions, points, and Urdu translations.
- `achievement.dart`: Defines unlock criteria, icons, reward coins, and unlock state.
- `school_class.dart`: Defines the 5 school environments, level spans, and themes.
- `player_progress.dart`: The single persistent model tracking total score, coins, current/highest streak, completed levels, level stars (1-3), discovered words, and settings.

### `lib/game/`
- `word_validator.dart`: Pure function validation engine enforcing letter frequency bounds, dictionary validity, minimum length, and duplicate checks.
- `scoring_engine.dart`: Computes word point values and handles one-time level bonuses.
- `hint_system.dart`: Deducts coins and calculates dynamic hints from remaining undiscovered words.
- `game_engine.dart`: The primary state controller managing active level state, tile selection, submissions, and achievement triggers.
- `timed_challenge_engine.dart`: Independent 60-second speed challenge controller with separate high scores.

### `lib/data/`
- `level_repository.dart`: Loads and queries 30 offline levels from `assets/data/levels.json`.
- `word_repository.dart`: Offline lookup engine for 159+ verified Urdu meanings from `assets/data/urdu_meanings.json`.
- `achievement_repository.dart`: Manages achievement definitions from `assets/data/achievements.json`.
- `scoring_config.dart`: Centralized configuration constants for all scoring rules and hint costs.

### `lib/services/`
- `storage_service.dart`: Serializes and restores `PlayerProgress` to local storage with robust fallback for unit test and standalone environments.
- `audio_service.dart`: Lightweight native system sound and haptic feedback triggers with sound toggle support.

### `lib/screens/`
Ten distinct, responsive, portrait-optimized mobile game screens with custom schoolroom styling.
