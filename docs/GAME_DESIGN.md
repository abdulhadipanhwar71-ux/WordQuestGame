# Game Design Document: Word Quest - Word School

## 1. High Concept
An educational mobile word-spelling game where players navigate through five themed school classrooms, spelling valid English words from letter tiles, earning coins, unlocking achievements, and learning Urdu meanings.

## 2. Target Audience & Core Loop
- **Audience**: Students, ESL learners, word puzzle enthusiasts of all ages.
- **Core Loop**:
  1. Inspect available letter tiles.
  2. Tap tiles to spell an approved English word.
  3. Submit word -> Earn immediate score + visual feedback + Urdu meaning.
  4. Meet level objective (e.g. find 3 or 4 target words).
  5. Earn stars & coins -> Unlock next school room!

## 3. The 5 School Classes & Environments
1. **Class 1: Beginner (Classroom 101)**
   - *Levels*: 1 to 6
   - *Letters*: 3 letters (e.g. C-A-T, D-O-G, P-A-N)
   - *Theme Color*: Kindergarten Green (`#43A047`)
2. **Class 2: Explorer (School Library)**
   - *Levels*: 7 to 12
   - *Letters*: 3 & 4 letters (e.g. C-A-T-R, S-T-A-R, P-L-A-Y)
   - *Theme Color*: Library Blue (`#1E88E5`)
3. **Class 3: Word Builder (Science Lab)**
   - *Levels*: 13 to 18
   - *Letters*: 4 letters (e.g. G-A-M-E, T-I-M-E, L-I-F-E)
   - *Theme Color*: Lab Orange (`#FB8C00`)
4. **Class 4: Scholar (Language Lab)**
   - *Levels*: 19 to 24
   - *Letters*: 4 & 5 letters (e.g. P-L-A-N-T, S-M-A-R-T, T-R-A-I-N)
   - *Theme Color*: Scholar Purple (`#8E24AA`)
5. **Class 5: Master (Grand Auditorium)**
   - *Levels*: 25 to 30
   - *Letters*: 5 & 6 letters (e.g. S-C-H-O-O-L, G-A-R-D-E-N, P-E-N-C-I-L, F-R-I-E-N-D, F-L-O-W-E-R)
   - *Theme Color*: Master Magenta (`#D81B60`)

## 4. Scoring Configuration
- 2 letters: 2 pts (when allowed by level)
- 3 letters: 5 pts
- 4 letters: 10 pts
- 5 letters: 15 pts
- 6+ letters: 20 pts
- Level completion bonus: 20 bonus points (awarded strictly on first completion).

## 5. Economic & Hint System
- Starting coin balance: 60 coins.
- **Hint 1: Reveal First Letter**: 10 coins. Unveils the starting character of an undiscovered word.
- **Hint 2: Reveal Word Length**: 5 coins. Unveils how many letters are in an undiscovered word.
- **Hint 3: Reveal Urdu Meaning**: 15 coins. Provides the verified Urdu translation as a clue.
- Coins cannot drop below zero.

## 6. Urdu Translation Integration
- Bundled database with 100% verified translations.
- Provides Urdu script and romanized English pronunciation for optimal learning.
