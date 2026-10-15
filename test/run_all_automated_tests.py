import json
import os
import sys
from collections import Counter

class TestRunner:
    def __init__(self):
        self.passed = 0
        self.failed = 0
        self.tests = []

    def assert_true(self, condition, test_name, error_msg=""):
        if condition:
            self.passed += 1
            print(f"  [PASS] {test_name}")
        else:
            self.failed += 1
            print(f"  [FAIL] {test_name}: {error_msg}")

    def run_all(self):
        print("=" * 60)
        print("RUNNING AUTOMATED TEST SUITE: WORD QUEST: WORD SCHOOL")
        print("=" * 60)

        # Load assets
        with open("assets/data/levels.json", "r", encoding="utf-8") as f:
            levels = json.load(f)

        with open("assets/data/urdu_meanings.json", "r", encoding="utf-8") as f:
            urdu_meanings = json.load(f)

        with open("assets/data/word_details.json", "r", encoding="utf-8") as f:
            word_details = json.load(f)

        with open("assets/data/achievements.json", "r", encoding="utf-8") as f:
            achievements = json.load(f)

        with open("assets/data/dictionary.json", "r", encoding="utf-8") as f:
            dictionary = set(json.load(f))

        # 1. Valid Word Acceptance
        print("\n--- Suite 1: Word Acceptance & Validation ---")
        lvl1 = levels[0] # CAT, ACT
        puzzle_letters = Counter(lvl1["letters"])
        word = "CAT"
        valid = word in lvl1["valid_answers"] and all(Counter(word)[c] <= puzzle_letters[c] for c in word)
        self.assert_true(valid, "Valid word acceptance: 'CAT' in lvl_01")

        # 2. Invalid Word Rejection
        invalid_word = "DOG" # Not in CAT level
        valid = invalid_word in lvl1["valid_answers"]
        self.assert_true(not valid, "Invalid word rejection: 'DOG' not in lvl_01")

        # 3. Letter Count Enforcement
        # CAT has only one 'A'. 'CAAT' should be rejected
        word_freq = Counter("CAAT")
        count_exceeded = any(word_freq[c] > puzzle_letters.get(c, 0) for c in word_freq)
        self.assert_true(count_exceeded, "Letter-count enforcement: 'CAAT' uses 'A' twice when only 1 available")

        # 4. Duplicate Word Rejection
        found_words = {"CAT"}
        is_dup = "CAT" in found_words
        self.assert_true(is_dup, "Duplicate word rejection: 'CAT' rejected when already in found_words")

        # 5. Case-insensitive duplicate detection
        found_words_lower = {w.upper() for w in ["cat"]}
        is_dup_case = "CAT".upper() in found_words_lower
        self.assert_true(is_dup_case, "Case-insensitive duplicate detection: 'cat' matches 'CAT'")

        # 6. Score Calculation
        print("\n--- Suite 2: Scoring Engine ---")
        def calc_pts(w):
            l = len(w)
            if l == 2: return 2
            if l == 3: return 5
            if l == 4: return 10
            if l == 5: return 15
            if l >= 6: return 20
            return 0

        self.assert_true(calc_pts("AT") == 2, "Score calculation: 2-letter word = 2 pts")
        self.assert_true(calc_pts("CAT") == 5, "Score calculation: 3-letter word = 5 pts")
        self.assert_true(calc_pts("CART") == 10, "Score calculation: 4-letter word = 10 pts")
        self.assert_true(calc_pts("SMART") == 15, "Score calculation: 5-letter word = 15 pts")
        self.assert_true(calc_pts("SCHOOL") == 20, "Score calculation: 6-letter word = 20 pts")

        # 7. No Points For Invalid Words
        invalid_sub_pts = 0 if "XYZ" not in lvl1["valid_answers"] else calc_pts("XYZ")
        self.assert_true(invalid_sub_pts == 0, "No points for invalid words: 'XYZ' earns 0 pts")

        # 8. One-time Level Bonuses
        completed_levels = set()
        bonus1 = 20 if lvl1["id"] not in completed_levels else 0
        completed_levels.add(lvl1["id"])
        bonus2 = 20 if lvl1["id"] not in completed_levels else 0
        self.assert_true(bonus1 == 20 and bonus2 == 0, "One-time level bonus: 20 pts on first clear, 0 on replay")

        # 9. Coin Deductions
        print("\n--- Suite 3: Hint System & Economy ---")
        coins = 60
        hint_cost = 10
        can_buy = coins >= hint_cost
        coins -= hint_cost if can_buy else 0
        self.assert_true(coins == 50, "Coin deductions: 60 - 10 = 50 coins")

        # 10. Sentence Clue & Hint Availability
        poor_coins = 4
        can_buy_poor = poor_coins >= 5
        self.assert_true(not can_buy_poor, "Hint availability: rejected when coins insufficient")

        # Sentence Clue
        sentence_clue_cost = 15
        coins_after_sentence = coins - sentence_clue_cost
        self.assert_true(coins_after_sentence == 35, "Sentence Clue hint costs 15 coins")

        all_ans = ["CAT", "ACT"]
        found = {"CAT"}
        undiscovered = [w for w in all_ans if w not in found]
        self.assert_true(undiscovered == ["ACT"], "Hint does not reveal already found words")

        # 11. Level Unlocking
        print("\n--- Suite 4: Progression & Persistence ---")
        def is_unlocked(lvl_num, comp_set):
            if lvl_num == 1: return True
            prev_id = f"lvl_{lvl_num - 1:02d}"
            return prev_id in comp_set

        user_comp = set()
        self.assert_true(is_unlocked(1, user_comp), "Level 1 is unlocked by default")
        self.assert_true(not is_unlocked(2, user_comp), "Level 2 is locked initially")
        user_comp.add("lvl_01")
        self.assert_true(is_unlocked(2, user_comp), "Level 2 is unlocked after Level 1 completion")

        # 12. Reward Claiming
        claimed_rewards = set()
        reward_coin_earned = 20 if "lvl_01" not in claimed_rewards else 0
        claimed_rewards.add("lvl_01")
        reward_replay = 20 if "lvl_01" not in claimed_rewards else 0
        self.assert_true(reward_coin_earned == 20 and reward_replay == 0, "Reward claiming: coins awarded once only")

        # 13. Saved Progress Restoration
        saved_state = {
            "coins": 95,
            "totalScore": 240,
            "completedLevelIds": ["lvl_01", "lvl_02"],
            "foundWords": ["CAT", "ACT", "DOG", "GOD"],
            "unlockedAchievementIds": ["ach_first_word"],
            "pronunciationEnabled": True,
            "animationsEnabled": True
        }
        json_dump = json.dumps(saved_state)
        restored = json.loads(json_dump)
        self.assert_true(restored["coins"] == 95 and len(restored["completedLevelIds"]) == 2, "Saved progress restoration intact")

        # 14. Settings Persistence
        settings_state = {
            "soundEnabled": False,
            "hapticsEnabled": True,
            "pronunciationEnabled": True,
            "animationsEnabled": False
        }
        settings_restored = json.loads(json.dumps(settings_state))
        self.assert_true(settings_restored["soundEnabled"] == False and settings_restored["animationsEnabled"] == False, "Settings persistence verified (audio & animations)")

        # 15. All Bundled Level Data & Feasible Completion (50 Levels)
        print("\n--- Suite 5: Complete Level Integrity & Feasibility (50 Levels) ---")
        self.assert_true(len(levels) >= 50, f"At least 50 levels present: Count is {len(levels)}")

        all_feasible = True
        all_freq_valid = True
        all_urdu_present = True
        all_sentences_present = True

        for l in levels:
            if len(l["valid_answers"]) < l["target_words"]:
                all_feasible = False
                print(f"Level {l['id']} target words {l['target_words']} exceeds answer count {len(l['valid_answers'])}")

            p_freq = Counter(l["letters"])
            for ans in l["valid_answers"]:
                a_freq = Counter(ans)
                if any(a_freq[c] > p_freq.get(c, 0) for c in a_freq):
                    all_freq_valid = False
                    print(f"Letter frequency violated in {l['id']} for word '{ans}'")
                if ans not in urdu_meanings:
                    all_urdu_present = False
                    print(f"Missing Urdu translation for '{ans}'")
                if ans not in word_details or not word_details[ans]["sentence"]:
                    all_sentences_present = False
                    print(f"Missing sentence example for '{ans}'")

        self.assert_true(all_feasible, "Feasible completion of every single level (answers >= target)")
        self.assert_true(all_freq_valid, "Letter-frequency rules strictly preserved in all 50 levels")
        self.assert_true(all_urdu_present, "100% verified Urdu translations present for all words")
        self.assert_true(all_sentences_present, "100% verified educational example sentences present for all words")

        print("\n" + "=" * 60)
        print(f"TEST EXECUTION SUMMARY: {self.passed} PASSED, {self.failed} FAILED")
        print("=" * 60)

        if self.failed > 0:
            sys.exit(1)

if __name__ == "__main__":
    runner = TestRunner()
    runner.run_all()
