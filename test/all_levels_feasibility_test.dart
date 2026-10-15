import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../lib/models/level.dart';

void main() {
  group('All 50 Levels Feasibility & Integrity Tests', () {
    late List<Level> allLevels;
    late Map<String, dynamic> urduMeanings;
    late Map<String, dynamic> wordDetails;

    setUpAll(() {
      final levelsFile = File('assets/data/levels.json');
      final urduFile = File('assets/data/urdu_meanings.json');
      final detailsFile = File('assets/data/word_details.json');

      final levelsJson = jsonDecode(levelsFile.readAsStringSync()) as List;
      allLevels = levelsJson
          .map((e) => Level.fromJson(e as Map<String, dynamic>))
          .toList();
      urduMeanings =
          jsonDecode(urduFile.readAsStringSync()) as Map<String, dynamic>;
      wordDetails =
          jsonDecode(detailsFile.readAsStringSync()) as Map<String, dynamic>;
    });

    test('Loads at least 50 distinct levels', () {
      expect(allLevels.length >= 50, true);
      final ids = allLevels.map((l) => l.id).toSet();
      expect(ids.length, allLevels.length); // All unique IDs
    });

    test('Every level has feasible objective and valid answers >= target', () {
      for (final lvl in allLevels) {
        expect(
          lvl.validAnswers.length >= lvl.targetWords,
          true,
          reason:
              'Level ${lvl.id} has only ${lvl.validAnswers.length} answers, target is ${lvl.targetWords}',
        );
      }
    });

    test(
        'Every single valid answer strictly adheres to letter frequency limits',
        () {
      for (final lvl in allLevels) {
        final puzzleFreq = <String, int>{};
        for (final ch in lvl.letters) {
          puzzleFreq[ch.toUpperCase()] =
              (puzzleFreq[ch.toUpperCase()] ?? 0) + 1;
        }

        for (final word in lvl.validAnswers) {
          final wordFreq = <String, int>{};
          for (int i = 0; i < word.length; i++) {
            final ch = word[i].toUpperCase();
            wordFreq[ch] = (wordFreq[ch] ?? 0) + 1;
            expect(
              wordFreq[ch]! <= (puzzleFreq[ch] ?? 0),
              true,
              reason:
                  'Level ${lvl.id}: Word "$word" uses "$ch" ${wordFreq[ch]} times, but level only has ${puzzleFreq[ch] ?? 0}',
            );
          }
          expect(word.length >= lvl.minWordLength, true);
        }
      }
    });

    test(
        'All vocabulary words have verified Urdu translations and educational details',
        () {
      for (final lvl in allLevels) {
        for (final word in lvl.validAnswers) {
          final upper = word.toUpperCase();
          expect(
            urduMeanings.containsKey(upper),
            true,
            reason: 'Missing Urdu translation for word "$upper"',
          );
          expect(
            wordDetails.containsKey(upper),
            true,
            reason: 'Missing word details/sentences for word "$upper"',
          );
        }
      }
    });
  });
}
