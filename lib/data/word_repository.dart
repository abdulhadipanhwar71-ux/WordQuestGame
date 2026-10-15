import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/word_entry.dart';

class WordRepository {
  Map<String, String> _urduMeanings = {};
  Map<String, Map<String, String>> _wordDetails = {};
  Set<String> _dictionary = {};

  bool get isLoaded => _urduMeanings.isNotEmpty;

  Future<void> load(
      {String? urduJson, String? dictJson, String? detailsJson}) async {
    final rawUrdu = urduJson ??
        await rootBundle.loadString('assets/data/urdu_meanings.json');
    final Map<String, dynamic> urduMap =
        jsonDecode(rawUrdu) as Map<String, dynamic>;
    _urduMeanings =
        urduMap.map((k, v) => MapEntry(k.toUpperCase(), v.toString()));

    try {
      final rawDetails = detailsJson ??
          await rootBundle.loadString('assets/data/word_details.json');
      final Map<String, dynamic> detailsMap =
          jsonDecode(rawDetails) as Map<String, dynamic>;
      _wordDetails = detailsMap.map((k, v) {
        final inner = v as Map<String, dynamic>;
        return MapEntry(k.toUpperCase(), {
          'sentence': inner['sentence']?.toString() ?? '',
          'sentence_urdu': inner['sentence_urdu']?.toString() ?? '',
        });
      });
    } catch (_) {
      _wordDetails = {};
    }

    try {
      final rawDict = dictJson ??
          await rootBundle.loadString('assets/data/dictionary.json');
      final List<dynamic> dictList = jsonDecode(rawDict) as List<dynamic>;
      _dictionary = dictList.map((e) => e.toString().toUpperCase()).toSet();
    } catch (_) {
      _dictionary = _urduMeanings.keys.toSet();
    }
  }

  void loadFromMaps(Map<String, String> meanings, Set<String> dictionary,
      [Map<String, Map<String, String>>? details]) {
    _urduMeanings = meanings.map((k, v) => MapEntry(k.toUpperCase(), v));
    _dictionary = dictionary.map((e) => e.toUpperCase()).toSet();
    if (details != null) {
      _wordDetails = details.map((k, v) => MapEntry(k.toUpperCase(), v));
    }
  }

  String getUrduMeaning(String word) {
    final upper = word.toUpperCase().trim();
    if (_urduMeanings.containsKey(upper)) {
      return _urduMeanings[upper]!;
    }
    return 'معنی دستیاب نہیں ہے (Meaning not available)';
  }

  String getExampleSentence(String word) {
    final upper = word.toUpperCase().trim();
    if (_wordDetails.containsKey(upper) &&
        _wordDetails[upper]!['sentence']!.isNotEmpty) {
      return _wordDetails[upper]!['sentence']!;
    }
    return 'The word "$upper" is used in daily English communication.';
  }

  String getExampleSentenceUrdu(String word) {
    final upper = word.toUpperCase().trim();
    if (_wordDetails.containsKey(upper) &&
        _wordDetails[upper]!['sentence_urdu']!.isNotEmpty) {
      return _wordDetails[upper]!['sentence_urdu']!;
    }
    return 'لفظ "$upper" روزمرہ انگریزی گفتگو میں استعمال ہوتا ہے۔';
  }

  WordEntry getWordEntry(String word, {bool isFound = false, String? levelId}) {
    final upper = word.toUpperCase().trim();
    return WordEntry(
      word: upper,
      urduMeaning: getUrduMeaning(upper),
      exampleSentence: getExampleSentence(upper),
      exampleSentenceUrdu: getExampleSentenceUrdu(upper),
      points: upper.length >= 5 ? 15 : (upper.length == 4 ? 10 : 5),
      isFound: isFound,
      discoveredInLevelId: levelId,
    );
  }

  bool hasUrduMeaning(String word) {
    return _urduMeanings.containsKey(word.toUpperCase().trim());
  }

  bool isDictionaryWord(String word) {
    final upper = word.toUpperCase().trim();
    return _dictionary.contains(upper) || _urduMeanings.containsKey(upper);
  }

  Map<String, String> get allMeanings => Map.unmodifiable(_urduMeanings);
}
