# Android Build and Installation Guide: Word Quest - Word School (Professional Upgrade)

## 1. Verified Android APK Deliverable

- **Build Status**: **SUCCESSFUL**
- **Exact APK Path**:  
  `D:\WordQuestGame\build\app\outputs\flutter-apk\app-debug.apk`
- **Convenient Top-Level Copy**:  
  `D:\WordQuest.apk`
- **Preserved Original Backup**:  
  `D:\WordQuestGame_Backup_Phase1\app-debug-original.apk` (88,796,701 bytes)
- **New APK File Size**: **102,178,274 bytes** (~97.44 MB)
- **Target OS**: Android 5.0 (API 21) up to Android 14+ (API 34)
- **Architecture**: Universal (supports ARM64, ARMv7, and x86_64 devices)
- **Features Included**:
  - Full Swipe-to-Connect Letter Puzzle Wheel with glowing continuous line rendering
  - Post-Level Vocabulary Screen with English example sentences & Urdu sentence translations
  - Offline Audio Sound Effects (Tap, Connect, Correct, Error, Hint, Coin, Fanfare)
  - Offline English Voice Pronunciation using Android native TTS
  - Celebration Falling Petals Animation (toggleable in Settings)
  - 50 Educational Levels across 5 School Classes (10 levels each)
  - 4 Hint Modes (First Letter, Word Length, Urdu Meaning, Sentence Clue)
  - 100% Offline with zero cloud or network dependencies

---

## 2. Step-by-Step Instructions to Install on an Android Phone (موبائل میں انسٹال کرنے کا آسان طریقہ)

### طریقہ 1: کمپیوٹر سے موبائل میں فائل کاپی کرنا (آسان ترین طریقہ)

1. **موبائل کو یو ایس بی کیبل کے ذریعے کمپیوٹر سے جوڑیں** (یا واٹس ایپ، ٹیلی گرام، یا بلوٹوتھ کے ذریعے بھیجیں)۔
2. کمپیوٹر پر ڈرائیو **D:** پر جائیں اور فائل کاپی کریں:  
   `D:\WordQuest.apk`  
   *(یا `D:\WordQuestGame\build\app\outputs\flutter-apk\app-debug.apk`)*
3. اس فائل کو اپنے موبائل کے **Download** یا **Internal Storage** فولڈر میں پیسٹ کر دیں۔
4. اپنے موبائل پر:
   - **Files** یا **File Manager** کھولیں۔
   - **Downloads** فولڈر میں جائیں اور **`WordQuest.apk`** پر ٹیپ کریں۔
   - اگر موبائل پر میسج آئے *"Install unknown apps"* تو **Settings** پر جا کر **Allow from this source** کو آن کریں۔
   - **Install** کا بٹن دبائیں۔
   - انسٹال ہونے کے بعد **Open** دبائیں، گیم مکمل طور پر چل پڑے گی!

---

### Method 2: One-Click Installation via USB & ADB (Command Line)

If your phone is connected with **USB Debugging** enabled:
```powershell
& "D:\android-sdk\platform-tools\adb.exe" install -r "D:\WordQuest.apk"
```

---

## 3. How to Rebuild the APK in the Future

```cmd
set JAVA_HOME=D:\jdk-17\jdk-17.0.12+7
set ANDROID_HOME=D:\android-sdk
set PATH=D:\jdk-17\jdk-17.0.12+7\bin;D:\android-sdk\platform-tools;D:\flutter\bin;%PATH%

cd D:\WordQuestGame
flutter analyze
flutter test
flutter build apk --debug
```

---

## 4. Environment Components Summary
- **Flutter SDK**: `D:\flutter\bin\flutter.bat` (v3.24.3, Dart 3.5.3)
- **Java Home**: `D:\jdk-17\jdk-17.0.12+7` (OpenJDK 17.0.12 LTS)
- **Android SDK**: `D:\android-sdk` (Platform 34, Build-Tools 34.0.0 & 33.0.1)
- **Gradle**: Gradle 8.3 with Android Gradle Plugin 8.1.0
