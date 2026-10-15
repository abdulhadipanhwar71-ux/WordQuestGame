import json

# Comprehensive vocabulary dictionary for the 177 newly added words
NEW_WORDS_DATA = {
    "APE": ("لنگور / بن مانس (Langoor / Ban maanas)", "The ape climbed the tall tree quickly.", "لنگور تیزی سے اونچے درخت پر چڑھ گیا۔"),
    "ARCH": ("محراب / کمان (Mehraab / Kamaan)", "The stone arch stood over the castle gate.", "پتھر کی محراب قلعے کے دروازے پر قائم تھی۔"),
    "ARMED": ("مسلح / تیار (Musallah / Tayyar)", "The guard was armed with a shield.", "محافظ ڈھال سے مسلح تھا۔"),
    "BAR": ("پٹی / سلاخ / بار (Patti / Salaakh)", "He grabbed the metal bar for support.", "اس نے سہارے کے لیے دھاتی سلاخ پکڑ لی۔"),
    "BARN": ("گودام / مویشی خانہ (Godaam / Mawaishi khana)", "The farmer keeps sweet hay inside the barn.", "کسان گودام میں خشک گھاس رکھتا ہے۔"),
    "BED": ("بستر / پلنگ (Bistar / Palang)", "She rested on the soft bed after school.", "اسکول کے بعد اس نے نرم بستر پر آرام کیا۔"),
    "BEG": ("التجا کرنا / مانگنا (Iltija karna / Maangna)", "The hungry puppy seemed to beg for bread.", "بھوکا کتا روٹی مانگتا دکھائی دیا۔"),
    "BIN": ("ڈبہ / کوڑے دان (Dabba / Kooray daan)", "Always throw waste paper into the dust bin.", "ہمیشہ ردی کاغذ کوڑے دان میں ڈالیں۔"),
    "BRAIN": ("دماغ / عقل (Dimagh / Aql)", "Reading books sharpens your active brain.", "کتابیں پڑھنا آپ کے فعال دماغ کو تیز کرتا ہے۔"),
    "BRAN": ("چوکر / بھوسی (Chokar / Bhoosi)", "Wheat bran is very healthy for breakfast.", "گندم کا چوکر ناشتے کے لیے بہت صحت بخش ہے۔"),
    "BRIDE": ("دلہن (Dulhan)", "The beautiful bride wore a red dress.", "خوبصورت دلہن نے سرخ لباس پہنا تھا۔"),
    "BRIDGE": ("پل (Pul)", "We walked safely across the wide river bridge.", "ہم دریا کے چوڑے پل سے بحفاظت گزرے۔"),
    "CASE": ("معاملہ / ڈبہ / کیس (Mamla / Dabba)", "He packed his pencils into the small case.", "اس نے اپنی پنسلیں چھوٹے ڈبے میں رکھیں۔"),
    "CAST": ("ڈھالنا / پھینکنا (Dhaalna / Phainkna)", "The tall tower cast a long shadow at sunset.", "اونچے مینار نے غروب آفتاب پر لمبا سایہ ڈالا۔"),
    "CASTLE": ("قلعہ (Qila)", "The ancient king lived in a stone castle.", "قدیم بادشاہ پتھر کے قلعے میں رہتا تھا۔"),
    "CHAIR": ("کرسی (Kursi)", "Please sit comfortably on the classroom chair.", "براہ کرم کلاس روم کی کرسی پر آرام سے بیٹھیں۔"),
    "CLEAT": ("کھونٹی / جوتے کا کانٹا (Khoonti / Jootay ka kaanta)", "The runner laced his athletic cleat tightly.", "کھلاڑی نے اپنے جوتے کے فیتے مضبوطی سے باندھے۔"),
    "DAM": ("بند / ڈیم (Band / Dam)", "The water dam generates clean electricity.", "پانی کا ڈیم صاف ستھری بجلی پیدا کرتا ہے۔"),
    "DEW": ("شبنم / اوس (Shabnam / Oas)", "Fresh dew sparkled on morning grass blades.", "صبح گھاس کے پتوں پر تازہ شبنم چمک رہی تھی۔"),
    "DIG": ("کھودنا (Khodna)", "Children like to dig sand at the sunny beach.", "بچے دھوپ والے ساحل پر ریت کھودنا پسند کرتے ہیں۔"),
    "DIRE": ("سخت / خوفناک (Sakht / Khaufnak)", "The stranded travelers were in dire need of water.", "پھنسے ہوئے مسافروں کو پانی کی سخت ضرورت تھی۔"),
    "DOWN": ("نیچے (Neechay)", "The red ball rolled all the way down the hill.", "سرخ گیند پہاڑی سے بالکل نیچے لڑھک گئی۔"),
    "DREAM": ("خواب / تمنا (Khawab / Tamanna)", "Every student has a bright dream for the future.", "ہر طالب علم کا مستقبل کے لیے ایک روشن خواب ہوتا ہے۔"),
    "DREW": ("کھینچا / تصویر بنائی (Kheehncha / Tasweer banayi)", "The creative girl drew an impressive landscape.", "تخلیقی لڑکی نے ایک شاندار منظر کشی کی۔"),
    "DROWN": ("ڈوبنا (Doobna)", "Life jackets prevent swimmers from drowning.", "حفاظتی جیکٹس تیراکوں کو ڈوبنے سے بچاتی ہیں۔"),
    "EAT": ("کھانا (Khaana)", "We must eat fresh fruits to stay healthy.", "صحت مند رہنے کے لیے ہمیں تازہ پھل کھانے چاہیئں۔"),
    "ELM": ("ایک سایہ دار درخت (Elm Darakht)", "A magnificent elm tree shades the courtyard.", "ایک شاندار ایلم درخت صحن کو سایہ فراہم کرتا ہے۔"),
    "FOREST": ("جنگل (Jangal)", "Green pine trees grow tall in the quiet forest.", "پرامن جنگل میں سبز صنوبر کے درخت بلند ہوتے ہیں۔"),
    "FORT": ("قلعہ / کوٹ (Qila / Kot)", "The historical army defended the strong fort.", "تاریخی فوج نے مضبوط قلعے کا دفاع کیا۔"),
    "FORTE": ("خاص مہارت / خوبی (Khaas Maharat)", "Solving math puzzles was his greatest forte.", "ریاضی کے معمہ حل کرنا اس کی سب سے بڑی خوبی تھی۔"),
    "FORTS": ("قلعے (Qilay)", "Ancient forts guarded the borders of empires.", "قدیم قلعے سلطنتوں کی سرحدوں کی حفاظت کرتے تھے۔"),
    "FROST": ("پالا / کہرا (Pala / Kohra)", "Winter frost covered the glass window.", "سردیوں کے پالے نے شیشے کی کھڑکی کو ڈھانپ لیا۔"),
    "GATE": ("پھاٹک / بڑا دروازہ (Phatak / Darwaza)", "The school gate opens promptly at eight o'clock.", "اسکول کا پھاٹک ٹھیک آٹھ بجے کھلتا ہے۔"),
    "GRATE": ("انگیٹھی / رگڑنا (Angeethi / Ragar-na)", "Carefully grate some yellow cheese for pizza.", "پیزا کے لیے احتیاط سے پیلا پنیر کدوکش کریں۔"),
    "GREAT": ("عظیم / بڑا (Azeem / Bara)", "Quaid-e-Azam was a truly great leader.", "قائد اعظم واقعی ایک عظیم رہنما تھے۔"),
    "GRID": ("جالی / چوکور خانے (Jaali / Khane)", "The word puzzle is arranged inside a grid.", "الفاظ کا معمہ ایک جالی کے اندر ترتیب دیا گیا ہے۔"),
    "GRIP": ("پکڑ / گرفت (Pakad / Girift)", "Hold the pen with a steady and relaxed grip.", "قلم کو مضبوط اور پرسکون گرفت سے پکڑیں۔"),
    "GRIPS": ("گرفتیں (Giriftain)", "The athlete grips the parallel bars firmly.", "ایتھلیٹ سلاخوں کو مضبوطی سے پکڑتا ہے۔"),
    "HAIR": ("بال (Baal)", "She brushed her long shiny black hair.", "اس نے اپنے لمبے چمکدار سیاہ بالوں میں کنگھی کی۔"),
    "HATER": ("نفرت کرنے والا (Nafrat karne wala)", "Do not be a hater, spread kindness instead.", "نفرت کرنے والے نہ بنیں، اس کی بجائے مہربانی پھیلائیں۔"),
    "HEN": ("مرغی (Murghi)", "The white hen laid an egg this morning.", "سفید مرغی نے آج صبح ایک انڈا دیا۔"),
    "HENS": ("مرغیاں (Murghiyan)", "The farm hens roam around the sunny yard.", "فارم کی مرغیاں دھوپ والے صحن میں گھومتی ہیں۔"),
    "HIS": ("اس کا (مرد کے لیے) (Us ka)", "He carried his blue school bag proudly.", "اس نے اپنا نیلا اسکول بیگ فخر سے اٹھایا۔"),
    "INERT": ("بے حرکت / غیر فعال (Bay-harkat)", "Helium is an inert gas that does not react easily.", "ہیلیم ایک غیر فعال گیس ہے جو آسانی سے ردعمل نہیں کرتی۔"),
    "INTER": ("دفن کرنا (Dafan karna)", "Historians inter artifacts in museum collections.", "ماہرین تاریخ عجائب گھروں میں نوادرات محفوظ کرتے ہیں۔"),
    "ISLE": ("جزیرہ (Jazeera)", "The small green isle sat amid calm ocean waves.", "چھوٹا سبز جزیرہ سمندر کی پرسکون لہروں کے درمیان واقع تھا۔"),
    "LATE": ("دیر سے / تاخیر (Dair se / Taakheer)", "Never arrive late to your morning lectures.", "اپنے صبح کے لیکچرز میں کبھی دیر سے نہ پہنچیں۔"),
    "LEAST": ("سب سے کم (Sab se kam)", "Spend at least thirty minutes reading daily.", "روزانہ کم از کم تیس منٹ مطالعہ میں گزاریں۔"),
    "LEMON": ("لیمو (Leemo)", "Fresh lemon juice is sour and refreshing.", "تازہ لیموں کا رس کھٹا اور فرحت بخش ہوتا ہے۔"),
    "LET": ("اجازت دینا (Ijazat dena)", "Please let the curious students ask questions.", "براہ کرم متجسس طلباء کو سوالات پوچھنے دیں۔"),
    "LIME": ("میٹھا لیمو / چونا (Meetha leemo / Choona)", "Lime adds a delicious zest to fruit salads.", "لیموں پھلوں کے سلاد میں مزیدار ذائقہ پیدا کرتا ہے۔"),
    "LONE": ("اکیلا / تنہا (Akela / Tanha)", "A lone eagle soared high into the cloudless sky.", "ایک اکیلا عقاب بے بادل آسمان میں اونچا اڑا۔"),
    "MADE": ("بنایا (Banaya)", "The carpenter made a solid wooden study desk.", "بڑھئی نے پڑھائی کے لیے لکڑی کی مضبوط میز بنائی۔"),
    "MAKE": ("بنانا (Banana)", "Hard work and practice make you successful.", "محنت اور مشق آپ کو کامیاب بناتی ہے۔"),
    "MAKER": ("بنانے والا / خالق (Bananay wala)", "God is the supreme maker of the universe.", "خدا کائنات کا سب سے اعلیٰ خالق ہے۔"),
    "MARK": ("نشان / نمبر (Nishan / Number)", "Check the green mark on your homework sheet.", "اپنے ہوم ورک شیٹ پر سبز نشان چیک کریں۔"),
    "MARKET": ("بازار / منڈی (Bazaar / Mandi)", "Mom bought ripe apples at the village market.", "امی نے گاؤں کے بازار سے پکے ہوئے سیب خریدے۔"),
    "MATE": ("ساتھی / دوست (Saathi / Dost)", "He played chess with his classroom mate.", "اس نے اپنے ہم جماعت ساتھی کے ساتھ شطرنج کھیلی۔"),
    "MEAT": ("گوشت (Gosht)", "Meat provides valuable proteins for the body.", "گوشت جسم کے لیے قیمتی پروٹین مہیا کرتا ہے۔"),
    "MELON": ("خربوزہ (Kharbooza)", "Sweet juicy melon is delightful on hot days.", "میٹھا رسیلا خربوزہ گرم دنوں میں بہت پرلطف ہوتا ہے۔"),
    "MEN": ("مرد (جمع) (Mard)", "Wise men always think carefully before speaking.", "عقل مند مرد ہمیشہ بولنے سے پہلے سوچتے ہیں۔"),
    "MILE": ("میل (فاصلہ) (Mile)", "The school track is exactly one quarter mile.", "اسکول کا ٹریک بالکل ایک چوتھائی میل لمبا ہے۔"),
    "MOLE": ("تل / چھچھوندر (Til / Chhachhoondar)", "A tiny black mole appeared on his left cheek.", "اس کے بائیں گال پر ایک چھوٹا سا کالا تل تھا۔"),
    "NEAT": ("صاف ستھرا (Saaf suthra)", "Always keep your notebook neat and tidy.", "اپنی نوٹ بک کو ہمیشہ صاف ستھرا رکھیں۔"),
    "NERD": ("محنتی پڑھاکو (Pardhaku)", "The science nerd loved studying astronomy.", "سائنس کا شوقین پڑھاکو فلکیات کا مطالعہ پسند کرتا تھا۔"),
    "NEST": ("گھونسلہ (Ghoonsla)", "The sparrow built a cozy nest in the tree.", "چڑیا نے درخت پر ایک آرام دہ گھونسلہ بنایا۔"),
    "NESTS": ("گھونسلے (Ghoonslay)", "Birds build twig nests high above danger.", "پرندے خطرے سے دور اونچائی پر گھونسلے بناتے ہیں۔"),
    "NET": ("جال / نیٹ (Jaal / Net)", "The volleyball net was tied between two posts.", "والی بال کا جال دو کھمبوں کے درمیان باندھا گیا تھا۔"),
    "NETS": ("جالیاں (Jaaliyan)", "Fishermen cast strong nets into the sea.", "ماہی گیروں نے سمندر میں مضبوط جال پھینکے۔"),
    "NEW": ("نیا (Naya)", "He wore a smart new uniform on the first day.", "اس نے پہلے دن اسمارٹ نیا یونیفارم پہنا۔"),
    "NIT": ("جوئیں / معمولی خامی (Joon / Nami)", "Do not pick nits over trivial grammar mistakes.", "معمولی گرامر کی غلطیوں پر نکتہ چینی نہ کریں۔"),
    "NODE": ("گانٹھ / گرہ / موڑ (Gaanth / Girah)", "Each node in a network connects devices.", "نیٹ ورک میں ہر نوڈ آلات کو جوڑتا ہے۔"),
    "NOR": ("نہ ہی (Na hi)", "He has neither fear nor hesitation in speech.", "اس کے خطاب میں نہ خوف ہے اور نہ ہچکچاہٹ۔"),
    "NOSE": ("ناک (Naak)", "Humans use their nose to breathe and smell.", "انسان سانس لینے اور سونگھنے کے لیے ناک استعمال کرتے ہیں۔"),
    "NOW": ("ابھی / اب (Abhi / Ab)", "Start your study revision right now.", "اپنی پڑھائی کا اعادہ ابھی سے شروع کریں۔"),
    "NUT": ("اخروٹ / گری (Akhroot / Giri)", "Walnut is a nutritious and crunchy dry nut.", "اخروٹ ایک غذائیت سے بھرپور خشک میوہ ہے۔"),
    "NUTS": ("میوے (Meway)", "Roasted nuts make a delicious afternoon snack.", "بھنے ہوئے میوے دوپہر کا لذیذ ناشتہ بناتے ہیں۔"),
    "OMEN": ("شگون / علامت (Shagoon / Alamat)", "Clear blue skies were a promising omen for rain.", "صاف نیلا آسمان خوشگوار موسم کی علامت تھا۔"),
    "ONE": ("ایک (Aik)", "Honesty is the number one virtue in life.", "دیانت داری زندگی میں سب سے پہلی نیکی ہے۔"),
    "OPEN": ("کھولنا / کھلا (Kholna / Khula)", "Open your textbooks to chapter fifteen.", "اپنی درسی کتابیں پندرہویں باب پر کھولیں۔"),
    "OPENS": ("کھولتا ہے (Kholta hai)", "The school library opens early every morning.", "اسکول کی لائبریری ہر صبح جلدی کھلتی ہے۔"),
    "OWED": ("مقروض تھا / واجب الادا تھا (Wajib ul ada tha)", "He paid back the five coins he owed his friend.", "اس نے اپنے دوست کے واجب الادا پانچ سکے واپس کیے۔"),
    "OWNER": ("مالک (Maalik)", "The kind owner shared books with children.", "مہربان مالک نے بچوں کے ساتھ کتابیں شیئر کیں۔"),
    "PALE": ("زرد / مدھم (Zard / Madham)", "The pale morning moon slowly faded away.", "صبح کا مدھم چاند آہستہ آہستہ غائب ہو گیا۔"),
    "PANEL": ("تختہ / پینل (Takhta / Panel)", "The solar panel converts sunlight into power.", "سولر پینل سورج کی روشنی کو توانائی میں بدلتا ہے۔"),
    "PEAL": ("گونج / جھنکار (Goonj / Jhankaar)", "A loud peal of school bells signaled recess.", "اسکول کی گھنٹی کی اونچی گونج نے وقفے کا اشارہ دیا۔"),
    "PER": ("فی / ہر ایک (Fi / Har aik)", "The express train travels eighty miles per hour.", "تیز رفتار ٹرین اسی میل فی گھنٹہ کی رفتار سے سفر کرتی ہے۔"),
    "PERSON": ("شخص / فرد (Shakhs / Fard)", "Every educated person respects good manners.", "ہر تعلیم یافتہ شخص اچھے آداب کا احترام کرتا ہے۔"),
    "PET": ("پالتو جانور (Paaltu jaanwar)", "A friendly rabbit is a lovely family pet.", "ایک دوستانہ خرگوش ایک پیارا پالتو جانور ہے۔"),
    "PIG": ("سور (Suar)", "The little pig splashed in the cool mud.", "چھوٹا خنزیر ٹھنڈی کیچڑ میں نہایا۔"),
    "PINS": ("پنیں / سوئیاں (Pinnain)", "Use metal pins to secure notices on the board.", "نوٹس بورڈ پر کاغذات لگانے کے لیے پنیں استعمال کریں۔"),
    "PLANE": ("طیارہ / جہاز (Tayyara / Jahaaz)", "The silver airplane soared above the white clouds.", "چاندی جیسا ہوائی جہاز سفید بادلوں کے اوپر اڑا۔"),
    "PLANET": ("سیارہ (Sayyara)", "Earth is the third planet from the bright sun.", "زمین روشن سورج سے تیسرا سیارہ ہے۔"),
    "PLATE": ("پلیٹ / رکابی (Plate / Rikaabi)", "Put the warm bread onto a clean porcelain plate.", "گرم روٹی صاف چینی کی پلیٹ پر رکھیں۔"),
    "PLEA": ("درخواست / التجا (Darkhwast)", "The honest lawyer made a heartfelt plea in court.", "دیانت دار وکیل نے عدالت میں دلی التجا کی۔"),
    "PORE": ("مسام / باریک سوراخ (Masaam)", "Tiny pores on plant leaves absorb carbon dioxide.", "پودوں کے پتوں پر باریک مسام کاربن ڈائی آکسائیڈ جذب کرتے ہیں۔"),
    "PORES": ("مسامات (Masaamaat)", "Skin pores release sweat to keep the body cool.", "جلد کے مسامات جسم کو ٹھنڈا رکھنے کے لیے پسینہ خارج کرتے ہیں۔"),
    "PORTS": ("بندرگاہیں (Bandargahain)", "Cargo ships dock at deep ocean ports.", "مال بردار بحری جہاز گہرے سمندری بندرگاہوں پر لنگر انداز ہوتے ہیں۔"),
    "POSE": ("انداز / پوز (Andaaz / Pose)", "Smile and pose naturally for the class photo.", "کلاس تصویر کے لیے مسکرائیں اور قدرتی انداز اپنائیں۔"),
    "POSER": ("معمہ / مشکل سوال (Muamma / Mushkil sawal)", "The teacher posed a tricky brain poser.", "استاد نے دماغ کی مشق کے لیے ایک مشکل معمہ پیش کیا۔"),
    "PRO": ("ماہر / حامی (Maahir / Haami)", "With regular practice you can become a chess pro.", "باقاعدہ مشق سے آپ شطرنج کے ماہر بن سکتے ہیں۔"),
    "PRONE": ("مائل / شکار ہونے والا (Maa-il)", "Tired travelers are prone to making simple errors.", "تھکے ہوئے مسافر معمولی غلطیاں کرنے کے مائل ہوتے ہیں۔"),
    "RAN": ("بھاگا / دوڑا (Bhaaga / Dauda)", "The happy boy ran to embrace his parents.", "خوش بچہ اپنے والدین کو گلے لگانے کے لیے دوڑا۔"),
    "RATE": ("شرح / رفتار (Sharah / Raftaar)", "He reads at a remarkable rate of fifty pages.", "وہ پچاس صفحات کی شاندار رفتار سے مطالعہ کرتا ہے۔"),
    "REPS": ("دہرائیاں (Dohraiyan)", "Do ten reps of stretching exercises every day.", "ہر روز کھنچاؤ کی ورزش کی دس دہرائیاں کریں۔"),
    "RICH": ("امیر / دولت مند (Ameer / Dolatmand)", "A library is rich with thousands of ideas.", "ایک لائبریری ہزاروں نظریات سے مالا مال ہوتی ہے۔"),
    "RING": ("انگوٹھی / گھنٹی (Angoothi / Ghanti)", "He wore a silver ring on his index finger.", "اس نے اپنی شہادت کی انگلی پر چاندی کی انگوٹھی پہنی۔"),
    "RINGS": ("انگوٹھیاں / گھنٹیاں (Angoothiyan)", "Planetary rings circle the planet Saturn.", "سیاروی حلقے سیارہ زحل کے گرد چکر لگاتے ہیں۔"),
    "RIP": ("پھاڑنا (Phaardna)", "Do not rip or bend the pages of any book.", "کسی کتاب کے صفحات مت پھاڑیں اور نہ موڑیں۔"),
    "ROD": ("ڈنڈا / سلاخ (Danda / Salaakh)", "The fisherman held his flexible fishing rod.", "ماہی گیر نے اپنا لچکدار مچھلی پکڑنے کا ڈنڈا پکڑا۔"),
    "ROPE": ("رسی (Rassi)", "The scout tied a secure knot with nylon rope.", "اسکاؤٹ نے نائیلون کی رسی سے محفوظ گرہ لگائی۔"),
    "ROPES": ("رسیاں (Rassiyan)", "Sailors handle heavy ropes on the ship deck.", "جہاز کے عرشے پر ملاح بھاری رسیاں سنبھالتے ہیں۔"),
    "ROTE": ("رٹا لگانا (Ratta lagana)", "Understand the concepts instead of rote memorization.", "رٹا لگانے کے بجائے تصورات کو سمجھیں۔"),
    "ROWED": ("کشتی چلائی (Kashti chalayi)", "They rowed the wooden boat across the lake.", "انہوں نے جھیل کے پار لکڑی کی کشتی چلائی۔"),
    "SALE": ("فروخت / سیل (Farokht / Sale)", "The bookstore offered a grand back-to-school sale.", "کتابوں کی دکان نے اسکول کی واپسی پر بڑی سیل پیش کی۔"),
    "SALT": ("نمک (Namak)", "A pinch of salt brings out food flavor.", "ایک چٹکی نمک کھانے کا ذائقہ نکھارتی ہے۔"),
    "SCALE": ("پیمانہ / ترازو (Paimana / Tarazoo)", "We weighed the laboratory sample on the scale.", "ہم نے لیبارٹری کے نمونے کو ترازو پر تولا۔"),
    "SEAT": ("نشست / سیٹ (Nashist / Seat)", "Take your assigned seat in the examination hall.", "امتحانی ہال میں اپنی مخصوص نشست سنبھالیں۔"),
    "SENT": ("بھیجا (Bhaija)", "She sent a handwritten letter to her grandmother.", "اس نے اپنی دادی کو ہاتھ سے لکھا ہوا خط بھیجا۔"),
    "SET": ("طے کرنا / سیٹ (Tai karna / Set)", "Set an ambitious goal for your school year.", "اپنے تعلیمی سال کے لیے ایک بڑا مقصد طے کریں۔"),
    "SETS": ("مجموعے (Majmooay)", "Mathematicians study sets of prime numbers.", "ماہرین ریاضی مفرد اعداد کے مجموعوں کا مطالعہ کرتے ہیں۔"),
    "SHE": ("وہ (عورت کے لیے) (Woh)", "She is the top scoring student in science.", "وہ سائنس میں سب سے زیادہ نمبر حاصل کرنے والی طالبہ ہے۔"),
    "SHIN": ("پنڈلی (Pindli)", "Soccer players wear protective shin guards.", "فٹ بال کے کھلاڑی پنڈلی کے حفاظتی گارڈز پہنتے ہیں۔"),
    "SHINE": ("چمکنا (Chamakna)", "The bright stars shine across the midnight sky.", "روشن ستارے رات کے آسمان پر چمکتے ہیں۔"),
    "SIGN": ("علامت / دستخط کرنا (Alamat / Dastakhat)", "Follow the green traffic sign carefully.", "سبز ٹریفک اشارے پر احتیاط سے عمل کریں۔"),
    "SIN": ("گناہ (Gunaah)", "Kindness and fairness protect humanity from sin.", "مہربانی اور انصاف انسانیت کو گناہ سے بچاتے ہیں۔"),
    "SINE": ("سائن (ریاضیاتی نسبت) (Sine)", "Calculate the sine of thirty degrees in trigonometry.", "مثلثیات میں تیس درجے کے سائن کا حساب لگائیں۔"),
    "SING": ("گانا (Gaana)", "The school choir loves to sing uplifting anthems.", "اسکول کا گلوکاروں کا دستہ ترانے گانا پسند کرتا ہے۔"),
    "SLIM": ("دبلا / پتلا (Dubla / Patla)", "Regular jogging keeps your body fit and slim.", "روزانہ جاگنگ آپ کے جسم کو چست اور دبلا رکھتی ہے۔"),
    "SLIME": ("لیس / کیچڑ (Lees / Keechar)", "Snails leave a shiny trail of protective slime.", "گھونگھے حفاظتی لیس دار چمکدار راستہ چھوڑتے ہیں۔"),
    "SMILE": ("مسکراہٹ (Muskurahat)", "A gentle smile makes everyone feel welcome.", "ایک ہلکی مسکراہٹ ہر ایک کا خیر مقدم کرتی ہے۔"),
    "SOFT": ("نرم / ملائم (Narm / Malaaim)", "The cotton pillow felt wonderfully soft.", "روئی کا تکیہ حیرت انگیز طور پر نرم محسوس ہوا۔"),
    "SON": ("بیٹا (Beta)", "The loving father took his young son to school.", "شفیق والد اپنے چھوٹے بیٹے کو اسکول لے گئے۔"),
    "SPIN": ("گھومنا / چکر دینا (Ghoomna / Chakkar)", "Spin the colorful top across the smooth tile floor.", "ہموار فرش پر رنگ برنگے لٹو کو چکر دیں۔"),
    "SPORE": ("بیج دانہ / سپور (Beej dana)", "Mushrooms reproduce by releasing microscopic spores.", "کھمبیاں خوردبینی بیج دانوں کے ذریعے افزائش پاتی ہیں۔"),
    "SPRING": ("بہار / اچھلنا (Bahaar / Uchhalna)", "Colorful roses bloom in early spring.", "ابتدائی موسم بہار میں رنگ برنگے گلاب کھلتے ہیں۔"),
    "STALE": ("باسی (Baasi)", "Do not consume stale bread or spoiled food.", "باسی روٹی یا خراب کھانا مت کھائیں۔"),
    "STEAL": ("چرانا (Churana)", "Honest students never steal or cheat.", "دیانت دار طلباء کبھی چوری یا دھوکہ نہیں دیتے۔"),
    "STORE": ("دکان / ذخیرہ کرنا (Dukaan / Zakheera)", "Store your books safely inside your backpack.", "اپنی کتابیں اپنے بستے کے اندر محفوظ طریقے سے رکھیں۔"),
    "SUE": ("مقدمہ کرنا (Muqadma karna)", "Citizens have the right to sue for justice.", "شہریوں کو انصاف کے لیے مقدمہ دائر کرنے کا حق ہے۔"),
    "SUET": ("گردے کی چربی (Chabi)", "Birds feed on nutritious suet cakes in winter.", "سردیوں میں پرندے غذائیت سے بھرپور چربی والی خوراک کھاتے ہیں۔"),
    "SUN": ("سورج (Sooraj)", "The golden sun provides light and warmth to Earth.", "سنہرا سورج زمین کو روشنی اور حرارت فراہم کرتا ہے۔"),
    "SUNS": ("سورج (جمع) (Sooraj)", "Some distant galaxies contain millions of suns.", "کچھ دور دراز کی کہکشاؤں میں لاکھوں سورج ہوتے ہیں۔"),
    "SUNSET": ("غروب آفتاب (Ghuroob-e-Aftaab)", "The evening sunset painted clouds in crimson red.", "شام کے غروب آفتاب نے بادلوں کو گہرے سرخ رنگ میں رنگ دیا۔"),
    "TAG": ("لیبل / پکڑم پکڑائی (Label / Khel)", "Children played a spirited game of tag at recess.", "بچوں نے وقفے کے دوران پکڑم پکڑائی کا پرجوش کھیل کھیلا۔"),
    "TAKE": ("لینا / پکڑنا (Lena / Pakadna)", "Always take notes during your science experiments.", "اپنے سائنسی تجربات کے دوران ہمیشہ نوٹس لیں۔"),
    "TAKER": ("لینے والا (Lenay wala)", "He was an enthusiastic test taker and excelled.", "وہ ایک پرجوش امتحان دینے والا تھا اور اس نے شاندار کارکردگی دکھائی۔"),
    "TALE": ("کہانی / داستان (Kahani / Dastaan)", "Grandma told a magical tale of bravery and honor.", "دادی اماں نے بہادری اور عزت کی ایک جادوئی کہانی سنائی۔"),
    "TALES": ("کہانیاں (Kahaniyan)", "Fairy tales teach valuable moral lessons.", "پریوں کی کہانیاں قیمتی اخلاقی اسباق سکھاتی ہیں۔"),
    "TAPE": ("ٹیپ / پٹی (Tape / Patti)", "Use adhesive tape to mend the torn poster.", "پھٹے ہوئے پوسٹر کو جوڑنے کے لیے چپکنے والی ٹیپ استعمال کریں۔"),
    "TEA": ("چائے (Chai)", "A warm cup of herbal tea soothes the throat.", "ہربل چائے کا ایک گرم کپ گلے کو سکون دیتا ہے۔"),
    "TEAL": ("نیلگوں سبز رنگ (Neelgoon sabz)", "The school banner was designed in elegant teal.", "اسکول کا بینر خوبصورت نیلگوں سبز رنگ میں ڈیزائن کیا گیا تھا۔"),
    "TEAM": ("ٹیم / دستہ (Team / Dasta)", "Our school cricket team won the championship.", "ہماری اسکول کی کرکٹ ٹیم نے چیمپئن شپ جیت لی۔"),
    "TEAR": ("آنسو / پھاڑنا (Aansoo / Phaardna)", "A tear of joy glistened upon winning the gold medal.", "سونے کا تمغہ جیتنے پر خوشی کا آنسو چمکا۔"),
    "TEN": ("دس (Das)", "A decade consists of ten productive calendar years.", "ایک دہائی دس نتیجہ خیز تقویمی سالوں پر مشتمل ہوتی ہے۔"),
    "TERM": ("مدت / اصطلاح (Muddat / Istilah)", "Complete your project before the end of term.", "ٹرم ختم ہونے سے پہلے اپنا پراجیکٹ مکمل کریں۔"),
    "TIER": ("درجہ / تہہ (Darja / Teh)", "The library books are categorized into three tiers.", "لائبریری کی کتابوں کو تین درجات میں تقسیم کیا گیا ہے۔"),
    "TOE": ("پاؤں کی انگلی (Paoon ki ungli)", "He stubbed his big toe against the wooden bench.", "اس کے پاؤں کا انگوٹھا لکڑی کے بینچ سے ٹکرا گیا۔"),
    "TOPS": ("چوٹیاں / لٹو (Chotiyan / Lattu)", "Snow covers the mountain tops throughout winter.", "سردیوں کے دوران برف پہاڑوں کی چوٹیوں کو ڈھانپ لیتی ہے۔"),
    "TORE": ("پھاڑ دیا (Phaard diya)", "The strong wind tore the old paper kite.", "تیز ہوا نے پرانی کاغذی پتنگ پھاڑ دی۔"),
    "TUNE": ("دھن / سر (Dhun / Sur)", "The violinist played a melodious classical tune.", "وائلن نواز نے ایک سریلی کلاسیکی دھن بجائی۔"),
    "TUNES": ("دھنیں (Dhunain)", "Inspiring tunes lifted everyone's spirits in assembly.", "حوصلہ افزا دھنوں نے اسمبلی میں سب کے حوصلے بلند کیے۔"),
    "TWIN": ("جڑواں (Jurwan)", "The twin brothers wore matching school blazers.", "جڑواں بھائیوں نے ایک جیسے اسکول بلیزر پہنے۔"),
    "TWINE": ("ڈوری / سوتلی (Dori / Sootli)", "Secure the parcel package with sturdy twine.", "مضبوط سوتلی کے ساتھ پارسل کے پیکٹ کو محفوظ کریں۔"),
    "USE": ("استعمال کرنا (Istemaal karna)", "Use your time productively to gain knowledge.", "علم حاصل کرنے کے لیے اپنا وقت نتیجہ خیز طریقے سے استعمال کریں۔"),
    "USES": ("استعمالات (Istemaalaat)", "Electricity has hundreds of essential daily uses.", "بجلی کے سینکڑوں روزمرہ ضروری استعمالات ہیں۔"),
    "WED": ("شادی کرنا (Shaadi karna)", "The happy couple will wed next month.", "خوش جوڑا اگلے ماہ شادی کرے گا۔"),
    "WENT": ("گیا (Gaya)", "The class went on an exciting museum field trip.", "کلاس ایک دلچسپ میوزیم کے مطالعاتی دورے پر گئی۔"),
    "WET": ("گیلا / تر (Geela / Tar)", "Do not walk on wet slippery tile floors.", "گیلے پھسلن والے فرش پر مت چلیں۔"),
    "WINE": ("شراب (Sharaab)", "Grapes are harvested in vineyards.", "انگوروں کی باغات میں کٹائی کی جاتی ہے۔"),
    "WINTER": ("موسم سرما (Mausam-e-Sarma)", "Cozy woolen sweaters keep us warm in winter.", "گرم اونی سویٹر ہمیں سردیوں میں گرم رکھتے ہیں۔"),
    "WIRE": ("تار (Taar)", "Copper wire conducts electrical currents safely.", "تانبے کی تار برقی رو کو بحفاظت منتقل کرتی ہے۔"),
    "WON": ("جیتا (Jeeta)", "Our class won the annual science fair trophy.", "ہماری کلاس نے سالانہ سائنس میلے کی ٹرافی جیتی۔"),
    "WONDER": ("حیرت / تعجب (Hairat / Taajjub)", "Children gaze with wonder at night stars.", "بچے رات کے ستاروں کو حیرت سے دیکھتے ہیں۔"),
    "WORE": ("پہنا (Pehna)", "The proud graduate wore a black academic gown.", "فخر سے فارغ التحصیل نے کالا تعلیمی لباس پہنا۔"),
    "WORN": ("پہنا ہوا / پرانا (Pehna hua / Puraana)", "The worn encyclopedia was read by generations.", "پڑھی ہوئی پرانی انسائیکلوپیڈیا نسلوں نے مطالعہ کی۔"),
    "WRITE": ("لکھنا (Likhna)", "Write your daily journal entry every evening.", "ہر شام اپنا روزانہ ڈائری کا اندراج لکھیں۔")
}

# 1. Update urdu_meanings.json
with open('assets/data/urdu_meanings.json', 'r', encoding='utf-8') as f:
    urdu_meanings = json.load(f)

for w, data in NEW_WORDS_DATA.items():
    urdu_meanings[w] = data[0]

with open('assets/data/urdu_meanings.json', 'w', encoding='utf-8') as f:
    json.dump(urdu_meanings, f, indent=2, ensure_ascii=False)

print(f"Updated assets/data/urdu_meanings.json! Total words now: {len(urdu_meanings)}")

# 2. Build complete word_details.json for ALL words in levels
with open('assets/data/levels.json', 'r', encoding='utf-8') as f:
    levels = json.load(f)

all_words = set()
for l in levels:
    all_words.update(l['valid_answers'])

word_details = {}
for w in sorted(all_words):
    if w in NEW_WORDS_DATA:
        meaning, sentence, sentence_urdu = NEW_WORDS_DATA[w]
    else:
        meaning = urdu_meanings.get(w, f"{w} کا معنی")
        # Generate appropriate example sentence for existing 159 words
        sentence = f"The student learned the English word '{w}' in class."
        sentence_urdu = f"طالب علم نے کلاس میں انگریزی لفظ '{w}' سیکھا۔"
        
        # Specific high-frequency enhancements for existing common words
        if w == "CAT":
            sentence = "The fluffy cat drinks fresh warm milk."
            sentence_urdu = "پیاری بلی تازہ گرم دودھ پیتی ہے۔"
        elif w == "ACT":
            sentence = "Always act with kindness and honesty."
            sentence_urdu = "ہمیشہ مہربانی اور دیانت داری سے کام لیں۔"
        elif w == "DOG":
            sentence = "The loyal dog guards the front gate."
            sentence_urdu = "وفادار کتا سامنے کے دروازے کی حفاظت کرتا ہے۔"
        elif w == "GOD":
            sentence = "God created the vast and beautiful universe."
            sentence_urdu = "خدا نے وسیع اور خوبصورت کائنات تخلیق کی۔"
        elif w == "PAN":
            sentence = "Mother heats soup in the metal cooking pan."
            sentence_urdu = "امی دھاتی برتن میں سوپ گرم کرتی ہیں۔"
        elif w == "NAP":
            sentence = "A short afternoon nap restores your energy."
            sentence_urdu = "دوپہر کی مختصر نیند آپ کی توانائی بحال کرتی ہے۔"
        elif w == "TOP":
            sentence = "The student reached the top of the honor roll."
            sentence_urdu = "طالب علم اعزازی فہرست میں سب سے اوپر پہنچا۔"
        elif w == "POT":
            sentence = "Clay pots keep fresh water remarkably cool."
            sentence_urdu = "مٹی کے برتن تازہ پانی کو بہت ٹھنڈا رکھتے ہیں۔"
        elif w == "BAT":
            sentence = "He swung the wooden cricket bat with precision."
            sentence_urdu = "اس نے لکڑی کے کرکٹ بلے کو مہارت سے گھمایا۔"
        elif w == "STAR":
            sentence = "The brightest star guided sailors in the night."
            sentence_urdu = "سب سے روشن ستارے نے رات کو ملاحوں کی رہنمائی کی۔"
        elif w == "BIRD":
            sentence = "The blue bird chirps sweetly at sunrise."
            sentence_urdu = "نیلا پرندہ طلوع آفتاب پر میٹھی چہچہاہٹ کرتا ہے۔"
        elif w == "SHIP":
            sentence = "The cargo ship sailed across the peaceful ocean."
            sentence_urdu = "مال بردار بحری جہاز پرامن سمندر پر روانہ ہوا۔"
        elif w == "LAMP":
            sentence = "Turn on the study lamp to read in the evening."
            sentence_urdu = "شام کو مطالعہ کے لیے اسٹڈی لیمپ روشن کریں۔"
        elif w == "BOOK":
            sentence = "Open your favorite book and explore new worlds."
            sentence_urdu = "اپنی پسندیدہ کتاب کھولیں اور نئی دنیاؤں کی سیر کریں۔"
        elif w == "GARDEN":
            sentence = "Red roses and jasmine fragrance fill the garden."
            sentence_urdu = "سرخ گلاب اور چنبیلی کی خوشبو باغ کو مہکا دیتی ہے۔"
        elif w == "FRIEND":
            sentence = "A loyal friend stands by you in every difficulty."
            sentence_urdu = "ایک مخلص دوست ہر مشکل میں آپ کے ساتھ کھڑا ہوتا ہے۔"
        elif w == "PENCIL":
            sentence = "Sharpen your graphite pencil before writing."
            sentence_urdu = "لکھنے سے پہلے اپنی پنسل کو تراش لیں۔"
        elif w == "FLOWER":
            sentence = "The morning flower opened its colorful petals."
            sentence_urdu = "صبح کے پھول نے اپنی رنگ برنگی پنکھڑیاں کھول دیں۔"
        elif w == "SILVER":
            sentence = "The shiny silver medal was awarded to the runner."
            sentence_urdu = "چمکدار چاندی کا تمغہ دوڑنے والے کو دیا گیا۔"

    word_details[w] = {
        "meaning": meaning,
        "sentence": sentence,
        "sentence_urdu": sentence_urdu
    }

with open('assets/data/word_details.json', 'w', encoding='utf-8') as f:
    json.dump(word_details, f, indent=2, ensure_ascii=False)

print(f"Created assets/data/word_details.json with {len(word_details)} detailed entries!")

# 3. Update dictionary.json
with open('assets/data/dictionary.json', 'r', encoding='utf-8') as f:
    dictionary = set(json.load(f))

dictionary.update(all_words)
with open('assets/data/dictionary.json', 'w', encoding='utf-8') as f:
    json.dump(sorted(list(dictionary)), f, indent=2)

print(f"Updated assets/data/dictionary.json with {len(dictionary)} dictionary words!")
