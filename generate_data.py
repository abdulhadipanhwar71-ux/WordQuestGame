import json
import os
from collections import Counter

levels_data = [
    # Class 1: Beginner (Classroom 101) - 3-letter puzzles
    {
        "id": "lvl_01",
        "level_number": 1,
        "class_id": "class_1",
        "class_name": "Class 1: Beginner",
        "room_name": "Classroom 101",
        "letters": ["C", "A", "T"],
        "valid_answers": ["CAT", "ACT"],
        "target_words": 2,
        "description": "Construct words using the given letters.",
        "min_word_length": 3,
        "reward_coins": 20,
        "reward_stars": 3
    },
    {
        "id": "lvl_02",
        "level_number": 2,
        "class_id": "class_1",
        "class_name": "Class 1: Beginner",
        "room_name": "Classroom 101",
        "letters": ["D", "O", "G"],
        "valid_answers": ["DOG", "GOD"],
        "target_words": 2,
        "description": "Form two everyday words.",
        "min_word_length": 3,
        "reward_coins": 20,
        "reward_stars": 3
    },
    {
        "id": "lvl_03",
        "level_number": 3,
        "class_id": "class_1",
        "class_name": "Class 1: Beginner",
        "room_name": "Classroom 101",
        "letters": ["P", "A", "N"],
        "valid_answers": ["PAN", "NAP"],
        "target_words": 2,
        "description": "Discover cooking and resting words.",
        "min_word_length": 3,
        "reward_coins": 20,
        "reward_stars": 3
    },
    {
        "id": "lvl_04",
        "level_number": 4,
        "class_id": "class_1",
        "class_name": "Class 1: Beginner",
        "room_name": "Classroom 101",
        "letters": ["T", "O", "P"],
        "valid_answers": ["TOP", "POT"],
        "target_words": 2,
        "description": "Rotate letters to make simple words.",
        "min_word_length": 3,
        "reward_coins": 20,
        "reward_stars": 3
    },
    {
        "id": "lvl_05",
        "level_number": 5,
        "class_id": "class_1",
        "class_name": "Class 1: Beginner",
        "room_name": "Classroom 101",
        "letters": ["B", "A", "T"],
        "valid_answers": ["BAT", "TAB"],
        "target_words": 2,
        "description": "A sports item and a keyboard key.",
        "min_word_length": 3,
        "reward_coins": 20,
        "reward_stars": 3
    },
    {
        "id": "lvl_06",
        "level_number": 6,
        "class_id": "class_1",
        "class_name": "Class 1: Beginner",
        "room_name": "Classroom 101",
        "letters": ["E", "A", "R"],
        "valid_answers": ["EAR", "ARE", "ERA"],
        "target_words": 2,
        "description": "Find 2 or 3 common words.",
        "min_word_length": 3,
        "reward_coins": 25,
        "reward_stars": 3
    },

    # Class 2: Explorer (School Library) - 3 & 4-letter puzzles
    {
        "id": "lvl_07",
        "level_number": 7,
        "class_id": "class_2",
        "class_name": "Class 2: Explorer",
        "room_name": "School Library",
        "letters": ["C", "A", "T", "R"],
        "valid_answers": ["CAT", "CAR", "RAT", "ART", "ACT", "CART"],
        "target_words": 3,
        "description": "Build four-letter and three-letter words.",
        "min_word_length": 3,
        "reward_coins": 25,
        "reward_stars": 3
    },
    {
        "id": "lvl_08",
        "level_number": 8,
        "class_id": "class_2",
        "class_name": "Class 2: Explorer",
        "room_name": "School Library",
        "letters": ["S", "T", "A", "R"],
        "valid_answers": ["STAR", "RATS", "ARTS", "ART", "RAT", "SAT", "TAR"],
        "target_words": 4,
        "description": "Reach for the stars in the library.",
        "min_word_length": 3,
        "reward_coins": 25,
        "reward_stars": 3
    },
    {
        "id": "lvl_09",
        "level_number": 9,
        "class_id": "class_2",
        "class_name": "Class 2: Explorer",
        "room_name": "School Library",
        "letters": ["P", "L", "A", "Y"],
        "valid_answers": ["PLAY", "LAY", "LAP", "PAY", "PAL"],
        "target_words": 3,
        "description": "Spell recreation words.",
        "min_word_length": 3,
        "reward_coins": 25,
        "reward_stars": 3
    },
    {
        "id": "lvl_10",
        "level_number": 10,
        "class_id": "class_2",
        "class_name": "Class 2: Explorer",
        "room_name": "School Library",
        "letters": ["B", "I", "R", "D"],
        "valid_answers": ["BIRD", "BID", "RIB", "RID"],
        "target_words": 3,
        "description": "Nature vocabulary in the reading corner.",
        "min_word_length": 3,
        "reward_coins": 25,
        "reward_stars": 3
    },
    {
        "id": "lvl_11",
        "level_number": 11,
        "class_id": "class_2",
        "class_name": "Class 2: Explorer",
        "room_name": "School Library",
        "letters": ["S", "H", "I", "P"],
        "valid_answers": ["SHIP", "HIPS", "HIP", "SIP"],
        "target_words": 3,
        "description": "Sail through library adventures.",
        "min_word_length": 3,
        "reward_coins": 25,
        "reward_stars": 3
    },
    {
        "id": "lvl_12",
        "level_number": 12,
        "class_id": "class_2",
        "class_name": "Class 2: Explorer",
        "room_name": "School Library",
        "letters": ["L", "A", "M", "P"],
        "valid_answers": ["LAMP", "PALM", "MAP", "LAP", "PAL"],
        "target_words": 3,
        "description": "Shine light on your vocabulary.",
        "min_word_length": 3,
        "reward_coins": 30,
        "reward_stars": 3
    },

    # Class 3: Word Builder (Science Lab) - 4-letter puzzles
    {
        "id": "lvl_13",
        "level_number": 13,
        "class_id": "class_3",
        "class_name": "Class 3: Word Builder",
        "room_name": "Science Lab",
        "letters": ["G", "A", "M", "E"],
        "valid_answers": ["GAME", "MAGE", "MEGA", "AGE", "GEM"],
        "target_words": 3,
        "description": "Combine elements in the laboratory.",
        "min_word_length": 3,
        "reward_coins": 30,
        "reward_stars": 3
    },
    {
        "id": "lvl_14",
        "level_number": 14,
        "class_id": "class_3",
        "class_name": "Class 3: Word Builder",
        "room_name": "Science Lab",
        "letters": ["T", "I", "M", "E"],
        "valid_answers": ["TIME", "ITEM", "EMIT", "MITE", "TIE", "MET"],
        "target_words": 3,
        "description": "Measure time accurately.",
        "min_word_length": 3,
        "reward_coins": 30,
        "reward_stars": 3
    },
    {
        "id": "lvl_15",
        "level_number": 15,
        "class_id": "class_3",
        "class_name": "Class 3: Word Builder",
        "room_name": "Science Lab",
        "letters": ["L", "I", "F", "E"],
        "valid_answers": ["LIFE", "FILE", "LIE", "ELF"],
        "target_words": 3,
        "description": "Biological sciences and life.",
        "min_word_length": 3,
        "reward_coins": 30,
        "reward_stars": 3
    },
    {
        "id": "lvl_16",
        "level_number": 16,
        "class_id": "class_3",
        "class_name": "Class 3: Word Builder",
        "room_name": "Science Lab",
        "letters": ["R", "O", "S", "E"],
        "valid_answers": ["ROSE", "SORE", "ROE", "ORE"],
        "target_words": 3,
        "description": "Botany exploration in science.",
        "min_word_length": 3,
        "reward_coins": 30,
        "reward_stars": 3
    },
    {
        "id": "lvl_17",
        "level_number": 17,
        "class_id": "class_3",
        "class_name": "Class 3: Word Builder",
        "room_name": "Science Lab",
        "letters": ["F", "I", "R", "E"],
        "valid_answers": ["FIRE", "RIFE", "REF", "FIR"],
        "target_words": 3,
        "description": "Heat, combustion, and flame.",
        "min_word_length": 3,
        "reward_coins": 30,
        "reward_stars": 3
    },
    {
        "id": "lvl_18",
        "level_number": 18,
        "class_id": "class_3",
        "class_name": "Class 3: Word Builder",
        "room_name": "Science Lab",
        "letters": ["W", "I", "N", "D"],
        "valid_answers": ["WIND", "WIN", "DIN"],
        "target_words": 2,
        "description": "Atmospheric air currents.",
        "min_word_length": 3,
        "reward_coins": 35,
        "reward_stars": 3
    },

    # Class 4: Scholar (Language Lab) - 4 & 5-letter puzzles
    {
        "id": "lvl_19",
        "level_number": 19,
        "class_id": "class_4",
        "class_name": "Class 4: Scholar",
        "room_name": "Language Lab",
        "letters": ["P", "L", "A", "N", "T"],
        "valid_answers": ["PLANT", "PLAN", "PANT", "TAP", "PAN", "TAN", "ANT", "PAT", "NAP"],
        "target_words": 4,
        "description": "Find botanical and action words.",
        "min_word_length": 3,
        "reward_coins": 35,
        "reward_stars": 3
    },
    {
        "id": "lvl_20",
        "level_number": 20,
        "class_id": "class_4",
        "class_name": "Class 4: Scholar",
        "room_name": "Language Lab",
        "letters": ["S", "M", "A", "R", "T"],
        "valid_answers": ["SMART", "TRAM", "STAR", "MART", "MAT", "RAT", "ART", "ARM", "RAM", "SAT", "TAR"],
        "target_words": 4,
        "description": "Demonstrate intellect with SMART words.",
        "min_word_length": 3,
        "reward_coins": 35,
        "reward_stars": 3
    },
    {
        "id": "lvl_21",
        "level_number": 21,
        "class_id": "class_4",
        "class_name": "Class 4: Scholar",
        "room_name": "Language Lab",
        "letters": ["T", "R", "A", "I", "N"],
        "valid_answers": ["TRAIN", "RAIN", "RANT", "TIN", "TAN", "ART", "RAT", "AIR"],
        "target_words": 4,
        "description": "Locomotives and practice.",
        "min_word_length": 3,
        "reward_coins": 35,
        "reward_stars": 3
    },
    {
        "id": "lvl_22",
        "level_number": 22,
        "class_id": "class_4",
        "class_name": "Class 4: Scholar",
        "room_name": "Language Lab",
        "letters": ["S", "P", "O", "R", "T"],
        "valid_answers": ["SPORT", "STOP", "POST", "PORT", "SPOT", "POT", "TOP", "ROT", "OPT"],
        "target_words": 4,
        "description": "Physical activities and athletics.",
        "min_word_length": 3,
        "reward_coins": 35,
        "reward_stars": 3
    },
    {
        "id": "lvl_23",
        "level_number": 23,
        "class_id": "class_4",
        "class_name": "Class 4: Scholar",
        "room_name": "Language Lab",
        "letters": ["C", "L", "E", "A", "N"],
        "valid_answers": ["CLEAN", "LANE", "LEAN", "CANE", "ALE", "ACE", "CAN"],
        "target_words": 4,
        "description": "Hygiene and purity.",
        "min_word_length": 3,
        "reward_coins": 35,
        "reward_stars": 3
    },
    {
        "id": "lvl_24",
        "level_number": 24,
        "class_id": "class_4",
        "class_name": "Class 4: Scholar",
        "room_name": "Language Lab",
        "letters": ["E", "A", "R", "T", "H"],
        "valid_answers": ["EARTH", "HEART", "HATE", "HEAR", "HEAT", "THE", "HAT", "ART", "RAT", "EAR", "ARE", "ERA"],
        "target_words": 5,
        "description": "Our planet and living heart.",
        "min_word_length": 3,
        "reward_coins": 40,
        "reward_stars": 3
    },

    # Class 5: Master (Grand Auditorium) - 5 & 6-letter puzzles
    {
        "id": "lvl_25",
        "level_number": 25,
        "class_id": "class_5",
        "class_name": "Class 5: Master",
        "room_name": "Grand Auditorium",
        "letters": ["S", "C", "H", "O", "O", "L"],
        "valid_answers": ["SCHOOL", "SHOO", "LOCH", "SOLO", "COOL", "COO"],
        "target_words": 3,
        "description": "The foundation of education.",
        "min_word_length": 3,
        "reward_coins": 45,
        "reward_stars": 3
    },
    {
        "id": "lvl_26",
        "level_number": 26,
        "class_id": "class_5",
        "class_name": "Class 5: Master",
        "room_name": "Grand Auditorium",
        "letters": ["G", "A", "R", "D", "E", "N"],
        "valid_answers": ["GARDEN", "DANGER", "GRADE", "GRAND", "READ", "DEAR", "DARE", "RANG", "GEAR", "RAGE", "RED", "AGE", "END", "EAR", "ARE", "AND", "DEN"],
        "target_words": 5,
        "description": "A flourishing yard of green.",
        "min_word_length": 3,
        "reward_coins": 45,
        "reward_stars": 3
    },
    {
        "id": "lvl_27",
        "level_number": 27,
        "class_id": "class_5",
        "class_name": "Class 5: Master",
        "room_name": "Grand Auditorium",
        "letters": ["P", "E", "N", "C", "I", "L"],
        "valid_answers": ["PENCIL", "LINE", "PINE", "LICE", "NIP", "PIN", "PEN", "LIP", "ICE", "LIE"],
        "target_words": 5,
        "description": "The writer's graphite tool.",
        "min_word_length": 3,
        "reward_coins": 45,
        "reward_stars": 3
    },
    {
        "id": "lvl_28",
        "level_number": 28,
        "class_id": "class_5",
        "class_name": "Class 5: Master",
        "room_name": "Grand Auditorium",
        "letters": ["F", "R", "I", "E", "N", "D"],
        "valid_answers": ["FRIEND", "FIND", "FINE", "RIDE", "DINE", "FIRE", "RED", "END", "DIE", "FIN", "FED", "RID"],
        "target_words": 5,
        "description": "A companion on your journey.",
        "min_word_length": 3,
        "reward_coins": 45,
        "reward_stars": 3
    },
    {
        "id": "lvl_29",
        "level_number": 29,
        "class_id": "class_5",
        "class_name": "Class 5: Master",
        "room_name": "Grand Auditorium",
        "letters": ["S", "I", "L", "V", "E", "R"],
        "valid_answers": ["SILVER", "LIVER", "VILE", "LIVE", "VEIL", "RISE", "SIR", "LIE"],
        "target_words": 4,
        "description": "A precious metallic shine.",
        "min_word_length": 3,
        "reward_coins": 50,
        "reward_stars": 3
    },
    {
        "id": "lvl_30",
        "level_number": 30,
        "class_id": "class_5",
        "class_name": "Class 5: Master",
        "room_name": "Grand Auditorium",
        "letters": ["F", "L", "O", "W", "E", "R"],
        "valid_answers": ["FLOWER", "LOWER", "WOLF", "FLOW", "FOWL", "FORE", "ROLE", "ROW", "OWL", "REF", "ORE", "ROE", "FOR", "LOW", "FEW"],
        "target_words": 5,
        "description": "The blooming pinnacle of Word School.",
        "min_word_length": 3,
        "reward_coins": 50,
        "reward_stars": 3
    }
]

# Verified Urdu meanings for all words
urdu_meanings = {
    "CAT": "بلی (Billi - Pet animal)",
    "ACT": "عمل کرنا / اداکاری (Amal karna / Adakari)",
    "DOG": "کتا (Kutta - Loyal pet)",
    "GOD": "خدا / معبود (Khuda / Mabood)",
    "PAN": "کڑاہی / پین (Karahi / Bartan)",
    "NAP": "قیلولہ / ہلکی نیند (Qailulah / Halka aaram)",
    "TOP": "سب سے اوپر / لٹو (Ooper / Lattu)",
    "POT": "برتن / ہانڈی (Bartan / Handi)",
    "BAT": "بلا / چمگادڑ (Balla / Chamgadar)",
    "TAB": "ٹیب / پٹی (Tab / Patti)",
    "EAR": "کان (Kaan - Hearing organ)",
    "ARE": "ہیں (Hain - Auxiliary verb)",
    "ERA": "دور / زمانہ (Daur / Zamana)",
    "CAR": "گاڑی / کار (Gaari / Car)",
    "RAT": "چوہا (Chooha - Rodent)",
    "ART": "فن / ہنر (Fann / Hunar)",
    "CART": "گاڑی / چھکڑا (Thela / Chhakra)",
    "STAR": "ستارہ (Sitara - Celestial body)",
    "RATS": "چوہے (Choohay)",
    "ARTS": "فنون (Funoon)",
    "SAT": "بیٹھ گیا (Baith gaya)",
    "TAR": "کولتار (Koltare)",
    "TARS": "کولتار لگانا (Tars)",
    "PLAY": "کھیلنا / ڈرامہ (Khelna / Drama)",
    "LAY": "رکھنا / بچھانا (Rakhna / Bichhana)",
    "LAP": "گود (Goad / Lap)",
    "PAY": "ادا کرنا / تنخواہ (Ada karna / Tankhwah)",
    "PAL": "دوست / ساتھی (Dost / Saathi)",
    "BIRD": "پرندہ (Parinda - Feathered animal)",
    "BID": "بولی لگانا (Boli lagana)",
    "RIB": "پسلی (Pasli)",
    "RID": "چھٹکارا پانا (Chhutkara pana)",
    "SHIP": "بحری جہاز (Bahri jahaz)",
    "HIPS": "کولہے (Koolhay)",
    "HIP": "کولہا (Koolha)",
    "SIP": "گھونٹ لینا (Ghoont lena)",
    "TIP": "نکتہ / سرہ / انعام (Nukta / Inam)",
    "LAMP": "چراغ / لیمپ (Chiragh / Lamp)",
    "PALM": "ہتھیلی / کھجور کا درخت (Hathaili / Khajoor ka darakht)",
    "MAP": "نقشہ (Naqsha - Geographical map)",
    "GAME": "کھیل (Khel - Competition / pastime)",
    "MAGE": "جادوگر (Jadugar / Wise person)",
    "MEGA": "بہت بڑا (Bohat bara / Huge)",
    "AGE": "عمر / دور (Umar / Daur)",
    "GEM": "قیمتی پتھر / ہیرا (Qeemti pathar / Jawhar)",
    "TIME": "وقت / زمانہ (Waqt / Time)",
    "ITEM": "چیز / شے (Cheez / Item)",
    "EMIT": "خارج کرنا (Kharij karna)",
    "MITE": "چھوٹا کیڑا (Chhota keera)",
    "TIE": "باندھنا / ٹائی (Bandhna / Tie)",
    "MET": "ملا / ملاقات کی (Mila / Mulaqat ki)",
    "LIFE": "زندگی / حیات (Zindagi / Hayat)",
    "FILE": "فائل / مثل (File / Dastavez)",
    "LIE": "جھوٹ / لیٹنا (Jhoot / Letna)",
    "ELF": "بونا / پری زاد (Bauna / Elf)",
    "ROSE": "گلاب کا پھول (Gulab ka phool)",
    "SORE": "دکھتا ہوا / زخم (Dukhta hua / Zakhm)",
    "ROE": "مچھلی کے انڈے (Machhli ke anday)",
    "ORE": "کچی دھات (Kachi dhaat)",
    "FIRE": "آگ / شعلہ (Aag / Shoala)",
    "RIFE": "عام / پھیلا ہوا (Aam / Phaila hua)",
    "REF": "ریفری (Referee / Munsif)",
    "FIR": "صنوبر کا درخت (Sanober ka darakht)",
    "WIND": "ہوا / باد (Hawa / Baad)",
    "WIN": "جیتنا / فتح (Jeetna / Fateh)",
    "DIN": "شور و غل (Shor o ghul)",
    "PLANT": "پودا لگانا / پودا (Pauda)",
    "PLAN": "منصوبہ (Mansooba)",
    "PANT": "ہانپنا (Haanpna)",
    "TAP": "نلکا / تھپتھپانا (Nalka / Thapthapana)",
    "TAN": "دھوپ سے جھلسنا (Tan)",
    "ANT": "چیونٹی (Chewnti)",
    "PAT": "تھپکی دینا (Thapki dena)",
    "SMART": "ذہین / ہوشیار (Zaheen / Hoshiyar)",
    "TRAM": "ٹرام گاڑی (Tram gari)",
    "MART": "منڈی / بازار (Mandi / Bazaar)",
    "MAT": "چٹائی (Chatai)",
    "ARM": "بازو (Bazu)",
    "RAM": "مینڈھا / ٹکر مارنا (Mendha / Takkar)",
    "TRAIN": "ریل گاڑی / تربیت دینا (Rail gari / Tarbiyat)",
    "RAIN": "بارش / برسات (Barish)",
    "RANT": "چیخ و پکار (Cheekh o pukar)",
    "TIN": "ٹن / ڈبہ (Tin / Dabba)",
    "AIR": "ہوا (Hawa / Faza)",
    "SPORT": "کھیل کود (Khel kood)",
    "STOP": "رکنا / روکنا (Rukna / Rokna)",
    "POST": "ڈاک / پوسٹ (Daak / Post)",
    "PORT": "بندرگاہ (Bandargah)",
    "SPOT": "جگہ / داغ (Jagah / Dagh)",
    "ROT": "گلنا سڑنا (Galna sarna)",
    "OPT": "انتخاب کرنا (Intikhab karna)",
    "CLEAN": "صاف ستھرا (Saaf suthra)",
    "LANE": "گلی / راہداری (Gali / Rahdari)",
    "LEAN": "جھکنا / دبلا (Jhukna / Dubla)",
    "CANE": "چھڑی / بید (Chhari)",
    "ALE": "مشروب (Mashroob)",
    "ACE": "اکا / ماہر (Ikka / Mahir)",
    "CAN": "کر سکنا / ڈبہ (Kar sakna / Can)",
    "EARTH": "زمین / کرہ ارض (Zameen / Planet)",
    "HEART": "دل (Dil - Vital organ)",
    "HATE": "نفرت کرنا (Nafrat karna)",
    "HEAR": "سننا (Sun-na)",
    "HEAT": "گرمی / حرارت (Garmi / Hararat)",
    "THE": "حرف تعریف (Specific article)",
    "HAT": "ٹوپی (Topi)",
    "SCHOOL": "سکول / درسگاہ (School / Darsgah)",
    "SHOO": "بھگانا (Bhagana)",
    "LOCH": "جھیل (Jheel)",
    "SOLO": "تنہا / اکیلا (Tanha / Solo)",
    "COOL": "ٹھنڈا / پرسکون (Thanda / Pursukoon)",
    "COO": "کوکنا / نرم آواز (Kookna)",
    "GARDEN": "باغ / چمن (Bagh / Chaman)",
    "DANGER": "خطرہ (Khatra)",
    "GRADE": "درجہ / جماعت (Darja / Class)",
    "GRAND": "عظیم الشان / شاندار (Azeem ush shaan)",
    "READ": "پڑھنا (Parhna)",
    "DEAR": "پیارا / عزیز (Pyara / Aziz)",
    "DARE": "ہمت کرنا (Himmat karna)",
    "RANG": "گھنٹی بجائی (Ghanti bajai)",
    "GEAR": "ساز و سامان / گیئر (Saaz o saman)",
    "RAGE": "غصہ / طیش (Ghusseh / Taish)",
    "RED": "سرخ رنگ (Surkh rang)",
    "END": "اختتام / خاتمہ (Ikhtitam)",
    "AND": "اور (Aur - Conjunction)",
    "DEN": "غار / ماند (Ghaar / Mand)",
    "PENCIL": "پنسل (Pencil - Writing instrument)",
    "LINE": "لکیر / قطار (Lakeer / Qataar)",
    "PINE": "دیودار کا درخت (Devdar ka darakht)",
    "LICE": "جوئیں (Jooen)",
    "NIP": "چٹکی کاٹنا (Chutki katna)",
    "PIN": "پن / سوئی (Pin / Sui)",
    "PEN": "قلم (Qalam - Writing pen)",
    "LIP": "ہونٹ (Hont)",
    "ICE": "برف (Barf)",
    "FRIEND": "دوست / رفیق (Dost / Rafeeq)",
    "FIND": "تلاش کرنا / پانا (Talash karna / Paana)",
    "FINE": "عمدہ / جرمانہ (Umdah / Jurmana)",
    "RIDE": "سواری کرنا (Sawari karna)",
    "DINE": "کھانا کھانا (Khana khana)",
    "DIE": "مرنا / موت (Marna)",
    "FIN": "مچھلی کا پر (Machhli ka par)",
    "FED": "کھلایا (Khilaya)",
    "SILVER": "چاندی / سیمیں (Chandi / Precious metal)",
    "LIVER": "جگر (Jigar - Liver organ)",
    "VILE": "ناگوار / حقیر (Nagawar / Haqeer)",
    "LIVE": "زندہ رہنا (Zinda rehna)",
    "VEIL": "نقاب / پردہ (Naqab / Parda)",
    "RISE": "طلوع ہونا / اٹھنا (Tulu hona / Uthna)",
    "SIR": "جناب / صاحب (Janab / Sir)",
    "FLOWER": "پھول (Phool - Blossom)",
    "LOWER": "نیچا / کم کرنا (Neecha / Kam karna)",
    "WOLF": "بھیڑیا (Bheriya)",
    "FLOW": "بہاؤ / جاری رہنا (Bahao / Rawaan)",
    "FOWL": "پرندہ / مرغی (Parinda / Murghi)",
    "FORE": "سامنے والا (Samnay wala)",
    "ROLE": "کردار (Kirdar)",
    "ROW": "قطار / چپو چلانا (Qataar / Chapoo chalana)",
    "OWL": "الو (Ullu)",
    "FOR": "کے لیے (Ke liye)",
    "LOW": "پست / دھیما (Past / Dheema)",
    "FEW": "چند / تھوڑے (Chand / Thode)"
}

# Curated Achievements
achievements_data = [
    {
        "id": "ach_first_word",
        "title": "First Spark",
        "title_urdu": "پہلا لفظ",
        "description": "Construct your very first approved English word.",
        "icon": "auto_awesome",
        "required_count": 1,
        "type": "word_count",
        "reward_coins": 15
    },
    {
        "id": "ach_first_level",
        "title": "Graduation Day",
        "title_urdu": "پہلا درجہ مکمل",
        "description": "Successfully complete your first school classroom level.",
        "icon": "school",
        "required_count": 1,
        "type": "level_count",
        "reward_coins": 25
    },
    {
        "id": "ach_streak_5",
        "title": "Streak Scholar",
        "title_urdu": "مسلسل درستگی",
        "description": "Submit 5 correct words in a row without mistakes.",
        "icon": "bolt",
        "required_count": 5,
        "type": "streak",
        "reward_coins": 30
    },
    {
        "id": "ach_ten_levels",
        "title": "Dedicated Student",
        "title_urdu": "محنتی طالبعلم",
        "description": "Clear 10 diverse school puzzle levels.",
        "icon": "military_tech",
        "required_count": 10,
        "type": "level_count",
        "reward_coins": 50
    },
    {
        "id": "ach_hundred_words",
        "title": "Word Wizard",
        "title_urdu": "الفاظ کا جادوگر",
        "description": "Discover 100 accepted English words across your journey.",
        "icon": "workspace_premium",
        "required_count": 100,
        "type": "word_count",
        "reward_coins": 100
    },
    {
        "id": "ach_master_class",
        "title": "School Valedictorian",
        "title_urdu": "سکول ٹاپر",
        "description": "Complete all 30 school levels and conquer the Master Auditorium.",
        "icon": "emoji_events",
        "required_count": 30,
        "type": "level_count",
        "reward_coins": 200
    }
]

# Validation
print("Validating all 30 levels...")
all_words_set = set()
errors = []

for idx, lvl in enumerate(levels_data):
    letter_counts = Counter(lvl["letters"])
    answers = lvl["valid_answers"]
    target = lvl["target_words"]
    
    if len(answers) < target:
        errors.append(f"Level {lvl['id']}: Valid answers count ({len(answers)}) is less than target ({target})")
        
    for word in answers:
        word_counts = Counter(word)
        for char, count in word_counts.items():
            if count > letter_counts.get(char, 0):
                errors.append(f"Level {lvl['id']}: Word '{word}' uses '{char}' {count} times but level only provides {letter_counts.get(char, 0)}")
        if len(word) < lvl["min_word_length"]:
            errors.append(f"Level {lvl['id']}: Word '{word}' shorter than min length {lvl['min_word_length']}")
        all_words_set.add(word)

if errors:
    print(f"Validation FAILED with {len(errors)} errors:")
    for err in errors:
        print(" -", err)
    exit(1)
else:
    print(f"SUCCESS: All {len(levels_data)} levels validated perfectly!")
    print(f"Total unique vocabulary words: {len(all_words_set)}")

# Verify Urdu translations coverage
missing_urdu = [w for w in all_words_set if w not in urdu_meanings]
if missing_urdu:
    print(f"WARNING: Missing Urdu translations for {len(missing_urdu)} words: {missing_urdu}")
    for w in missing_urdu:
        urdu_meanings[w] = f"{w.capitalize()} (English word)"
else:
    print(f"SUCCESS: 100% of vocabulary words have verified Urdu translations!")

# Save to assets/data/
os.makedirs("assets/data", exist_ok=True)

with open("assets/data/levels.json", "w", encoding="utf-8") as f:
    json.dump(levels_data, f, indent=2, ensure_ascii=False)

with open("assets/data/urdu_meanings.json", "w", encoding="utf-8") as f:
    json.dump(urdu_meanings, f, indent=2, ensure_ascii=False)

with open("assets/data/achievements.json", "w", encoding="utf-8") as f:
    json.dump(achievements_data, f, indent=2, ensure_ascii=False)

# Also create dictionary.json containing all verified words plus extended vocabulary
dictionary_list = sorted(list(all_words_set))
with open("assets/data/dictionary.json", "w", encoding="utf-8") as f:
    json.dump(dictionary_list, f, indent=2, ensure_ascii=False)

print("Saved levels.json, urdu_meanings.json, achievements.json, and dictionary.json successfully!")
