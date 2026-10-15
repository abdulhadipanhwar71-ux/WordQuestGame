import json
from collections import Counter

# Load existing levels
with open('assets/data/levels.json', 'r', encoding='utf-8') as f:
    existing_levels = json.load(f)

with open('assets/data/urdu_meanings.json', 'r', encoding='utf-8') as f:
    urdu_meanings = json.load(f)

# Classes mapping for 50 levels (10 levels per class)
classes_info = {
    "class_1": ("Class 1: Beginner", "Classroom 101"),
    "class_2": ("Class 2: Explorer", "School Library"),
    "class_3": ("Class 3: Word Builder", "Science Lab"),
    "class_4": ("Class 4: Scholar", "Language Lab"),
    "class_5": ("Class 5: Master", "Grand Auditorium"),
}

def get_class_for_level(lvl_num):
    if lvl_num <= 10:
        return "class_1"
    elif lvl_num <= 20:
        return "class_2"
    elif lvl_num <= 30:
        return "class_3"
    elif lvl_num <= 40:
        return "class_4"
    else:
        return "class_5"

all_levels = []

# Process existing 30 levels
for l in existing_levels:
    num = l["level_number"]
    cid = get_class_for_level(num)
    cname, rname = classes_info[cid]
    all_levels.append({
        "id": f"lvl_{num:02d}",
        "level_number": num,
        "class_id": cid,
        "class_name": cname,
        "room_name": rname,
        "letters": l["letters"],
        "valid_answers": l["valid_answers"],
        "target_words": l["target_words"],
        "description": l["description"],
        "min_word_length": l["min_word_length"],
        "reward_coins": l["reward_coins"],
        "reward_stars": l["reward_stars"]
    })

# Define 20 new levels (Levels 31 to 50)
new_levels_def = [
    # Level 31: BRAIN (5 letters, Class 4)
    {
        "num": 31,
        "letters": ["B", "R", "A", "I", "N"],
        "valid": ["BRAIN", "RAIN", "BARN", "BRAN", "AIR", "RIB", "BIN", "RAN", "BAR"],
        "target": 5,
        "desc": "Uncover words of mind and weather.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 32: CHAIR (5 letters, Class 4)
    {
        "num": 32,
        "letters": ["C", "H", "A", "I", "R"],
        "valid": ["CHAIR", "ARCH", "HAIR", "RICH", "AIR", "CAR"],
        "target": 4,
        "desc": "Construct seating and style words.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 33: DREAM (5 letters, Class 4)
    {
        "num": 33,
        "letters": ["D", "R", "E", "A", "M"],
        "valid": ["DREAM", "ARMED", "DARE", "DEAR", "MADE", "READ", "ARM", "RED", "DAM", "EAR"],
        "target": 5,
        "desc": "Build inspiring aspiration words.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 34: EARTH (5 letters, Class 4)
    {
        "num": 34,
        "letters": ["E", "A", "R", "T", "H"],
        "valid": ["EARTH", "HEART", "HATER", "HEAT", "HATE", "HEAR", "TEAR", "RATE", "ART", "EAR", "HAT", "THE", "EAT", "TEA"],
        "target": 6,
        "desc": "Discover our planetary home and nature.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 35: GREAT (5 letters, Class 4)
    {
        "num": 35,
        "letters": ["G", "R", "E", "A", "T"],
        "valid": ["GREAT", "GRATE", "TEAR", "RATE", "GATE", "GEAR", "RAGE", "ART", "EAR", "AGE", "TEA", "EAT", "TAG"],
        "target": 6,
        "desc": "Create grand and powerful words.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 36: LEMON (5 letters, Class 4)
    {
        "num": 36,
        "letters": ["L", "E", "M", "O", "N"],
        "valid": ["LEMON", "MELON", "MOLE", "LONE", "OMEN", "ONE", "MEN", "ELM"],
        "target": 4,
        "desc": "Discover sweet and sour orchard words.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 37: SMILE (5 letters, Class 4)
    {
        "num": 37,
        "letters": ["S", "M", "I", "L", "E"],
        "valid": ["SMILE", "SLIME", "MILE", "LIME", "SLIM", "ISLE", "LIE"],
        "target": 5,
        "desc": "Form cheerful words of joy and distance.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 38: PLANE (5 letters, Class 4)
    {
        "num": 38,
        "letters": ["P", "L", "A", "N", "E"],
        "valid": ["PLANE", "PANEL", "PLAN", "LANE", "LEAN", "PALE", "PEAL", "PLEA", "PEN", "NAP", "PAN", "PAL"],
        "target": 6,
        "desc": "Construct aviation and travel words.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 39: SHINE (5 letters, Class 4)
    {
        "num": 39,
        "letters": ["S", "H", "I", "N", "E"],
        "valid": ["SHINE", "SHIN", "SINE", "HENS", "HEN", "SHE", "HIS", "SIN"],
        "target": 5,
        "desc": "Spell luminous radiant words.",
        "min_len": 3,
        "coins": 30,
        "stars": 3
    },
    # Level 40: SPORT (5 letters, Class 4)
    {
        "num": 40,
        "letters": ["S", "P", "O", "R", "T"],
        "valid": ["SPORT", "PORTS", "POST", "STOP", "SPOT", "TOPS", "PORT", "POT", "TOP", "ROT", "OPT"],
        "target": 6,
        "desc": "Form athletic and recreational words.",
        "min_len": 3,
        "coins": 35,
        "stars": 3
    },
    # Level 41: SPRING (6 letters, Class 5)
    {
        "num": 41,
        "letters": ["S", "P", "R", "I", "N", "G"],
        "valid": ["SPRING", "RINGS", "RING", "GRIPS", "GRIP", "SPIN", "PINS", "SING", "SIGN", "PIG", "RIP", "PIN", "SIP"],
        "target": 7,
        "desc": "Welcome flourishing seasons of growth.",
        "min_len": 3,
        "coins": 35,
        "stars": 3
    },
    # Level 42: CASTLE (6 letters, Class 5)
    {
        "num": 42,
        "letters": ["C", "A", "S", "T", "L", "E"],
        "valid": ["CASTLE", "CLEAT", "SCALE", "STALE", "STEAL", "LEAST", "TALES", "CASE", "CAST", "LATE", "SALE", "SALT", "SEAT", "CAT", "ACT", "LET", "SET", "TEA", "EAT"],
        "target": 8,
        "desc": "Explore royal stone fortifications.",
        "min_len": 3,
        "coins": 35,
        "stars": 3
    },
    # Level 43: MARKET (6 letters, Class 5)
    {
        "num": 43,
        "letters": ["M", "A", "R", "K", "E", "T"],
        "valid": ["MARKET", "TAKER", "MAKER", "MAKE", "MARK", "MATE", "MEAT", "TAKE", "TEAR", "TEAM", "TERM", "ART", "ARM", "EAR", "ERA", "TEA", "EAT"],
        "target": 8,
        "desc": "Trade words in the bustling town market.",
        "min_len": 3,
        "coins": 35,
        "stars": 3
    },
    # Level 44: BRIDGE (6 letters, Class 5)
    {
        "num": 44,
        "letters": ["B", "R", "I", "D", "G", "E"],
        "valid": ["BRIDGE", "BRIDE", "BIRD", "DIRE", "GRID", "RIDE", "BED", "BEG", "BID", "DIE", "DIG", "RED", "RIB", "RID"],
        "target": 7,
        "desc": "Connect across rushing river waters.",
        "min_len": 3,
        "coins": 35,
        "stars": 3
    },
    # Level 45: FOREST (6 letters, Class 5)
    {
        "num": 45,
        "letters": ["F", "O", "R", "E", "S", "T"],
        "valid": ["FOREST", "FORTE", "FORTS", "FROST", "STORE", "FORT", "FORE", "ROSE", "ROTE", "SOFT", "SORE", "TORE", "FOR", "ROE", "ROT", "SET", "TOE"],
        "target": 8,
        "desc": "Wander through whispering woodlands.",
        "min_len": 3,
        "coins": 35,
        "stars": 3
    },
    # Level 46: PLANET (6 letters, Class 5)
    {
        "num": 46,
        "letters": ["P", "L", "A", "N", "E", "T"],
        "valid": ["PLANET", "PLANT", "PANEL", "PLANE", "PLATE", "LEAN", "LATE", "LANE", "NEAT", "PALE", "TALE", "TAPE", "TEAL", "ANT", "APE", "LET", "NET", "PAN", "PAT", "PEN", "PET", "TAN", "TAP", "TEA"],
        "target": 9,
        "desc": "Survey cosmic wonders orbiting the sun.",
        "min_len": 3,
        "coins": 40,
        "stars": 3
    },
    # Level 47: SUNSET (6 letters, Class 5)
    {
        "num": 47,
        "letters": ["S", "U", "N", "S", "E", "T"],
        "valid": ["SUNSET", "NESTS", "TUNES", "NEST", "NETS", "NUTS", "SENT", "SETS", "SUET", "SUNS", "TUNE", "USES", "NET", "NUT", "SET", "SUE", "SUN", "TEN", "USE"],
        "target": 8,
        "desc": "Gaze upon brilliant evening skies.",
        "min_len": 3,
        "coins": 40,
        "stars": 3
    },
    # Level 48: WINTER (6 letters, Class 5)
    {
        "num": 48,
        "letters": ["W", "I", "N", "T", "E", "R"],
        "valid": ["WINTER", "TWINE", "WRITE", "INERT", "INTER", "TIER", "TWIN", "WENT", "WINE", "WIRE", "NET", "NEW", "NIT", "TEN", "TIE", "TIN", "WET", "WIN"],
        "target": 8,
        "desc": "Brave frosty snowscapes and cold winds.",
        "min_len": 3,
        "coins": 40,
        "stars": 3
    },
    # Level 49: PERSON (6 letters, Class 5)
    {
        "num": 49,
        "letters": ["P", "E", "R", "S", "O", "N"],
        "valid": ["PERSON", "PRONE", "SPORE", "POSER", "ROPE", "ROPES", "ROSE", "NOSE", "OPEN", "OPENS", "PORE", "PORES", "POSE", "REPS", "SORE", "NOR", "ONE", "PEN", "PER", "PRO", "SON"],
        "target": 9,
        "desc": "Learn words of humanity and society.",
        "min_len": 3,
        "coins": 40,
        "stars": 3
    },
    # Level 50: WONDER (6 letters, Class 5)
    {
        "num": 50,
        "letters": ["W", "O", "N", "D", "E", "R"],
        "valid": ["WONDER", "DROWN", "OWNER", "ROWED", "DOWN", "DREW", "NERD", "NODE", "OWED", "WORE", "WORN", "DEN", "DEW", "END", "NEW", "NOW", "ONE", "ORE", "RED", "ROD", "ROW", "WED", "WON"],
        "target": 10,
        "desc": "The grand finale: celebrate curiosity and marvels of knowledge!",
        "min_len": 3,
        "coins": 50,
        "stars": 3
    }
]

for d in new_levels_def:
    num = d["num"]
    cid = get_class_for_level(num)
    cname, rname = classes_info[cid]
    all_levels.append({
        "id": f"lvl_{num:02d}",
        "level_number": num,
        "class_id": cid,
        "class_name": cname,
        "room_name": rname,
        "letters": d["letters"],
        "valid_answers": d["valid"],
        "target_words": d["target"],
        "description": d["desc"],
        "min_word_length": d["min_len"],
        "reward_coins": d["coins"],
        "reward_stars": d["stars"]
    })

print(f"Total levels assembled: {len(all_levels)}")

# Check feasibility and letter frequency for all 50 levels
all_valid = True
all_words = set()
for l in all_levels:
    p_freq = Counter(l["letters"])
    if len(l["valid_answers"]) < l["target_words"]:
        print(f"Error: Level {l['id']} targets {l['target_words']} but only has {len(l['valid_answers'])} answers!")
        all_valid = False
    for w in l["valid_answers"]:
        all_words.add(w)
        w_freq = Counter(w)
        for char, count in w_freq.items():
            if count > p_freq.get(char, 0):
                print(f"Error: Level {l['id']} word {w} uses {char} {count} times, but letters only have {p_freq.get(char, 0)}")
                all_valid = False

if all_valid:
    print(f"ALL 50 LEVELS VALIDATED 100% FEASIBLE! Unique words: {len(all_words)}")
else:
    raise SystemExit("Level validation failed!")

# Save levels.json
with open('assets/data/levels.json', 'w', encoding='utf-8') as f:
    json.dump(all_levels, f, indent=2, ensure_ascii=False)

print("Saved assets/data/levels.json successfully!")
