import 'package:flutter/material.dart';
import '../data/word_repository.dart';
import '../services/audio_service.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';

class WordLearningPanelScreen extends StatefulWidget {
  final WordRepository wordRepository;
  final StorageService storageService;

  const WordLearningPanelScreen({
    Key? key,
    required this.wordRepository,
    required this.storageService,
  }) : super(key: key);

  @override
  State<WordLearningPanelScreen> createState() =>
      _WordLearningPanelScreenState();
}

class _WordLearningPanelScreenState extends State<WordLearningPanelScreen> {
  String _searchQuery = '';
  bool _filterOnlyDiscovered = false;

  @override
  Widget build(BuildContext context) {
    final progress = widget.storageService.progress;
    final allMeanings = widget.wordRepository.allMeanings;

    // Filter words
    final filteredWords = allMeanings.keys.where((word) {
      final matchesQuery = word
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          allMeanings[word]!.toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesQuery) return false;
      if (_filterOnlyDiscovered && !progress.foundWords.contains(word)) {
        return false;
      }
      return true;
    }).toList()
      ..sort();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Word Learning Panel (الفاظ و معانی)'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search English word or Urdu meaning...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${filteredWords.length} words',
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                FilterChip(
                  label:
                      Text('Discovered Only (${progress.foundWords.length})'),
                  selected: _filterOnlyDiscovered,
                  onSelected: (val) =>
                      setState(() => _filterOnlyDiscovered = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filteredWords.isEmpty
                ? const Center(
                    child: Text('No words match your search query.'),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredWords.length,
                    itemBuilder: (context, index) {
                      final word = filteredWords[index];
                      final meaning = allMeanings[word]!;
                      final sentence =
                          widget.wordRepository.getExampleSentence(word);
                      final sentenceUrdu =
                          widget.wordRepository.getExampleSentenceUrdu(word);
                      final isDiscovered = progress.foundWords.contains(word);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isDiscovered
                                ? AppColors.successGreen.withOpacity(0.4)
                                : Colors.transparent,
                          ),
                        ),
                        child: ExpansionTile(
                          shape: const Border(),
                          collapsedShape: const Border(),
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          leading: CircleAvatar(
                            backgroundColor: isDiscovered
                                ? AppColors.successGreen
                                : Colors.grey.shade200,
                            foregroundColor: isDiscovered
                                ? Colors.white
                                : Colors.grey.shade700,
                            child: Text(
                              word.isNotEmpty ? word[0] : '?',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Row(
                            children: [
                              Text(
                                word,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (isDiscovered)
                                const Icon(Icons.check_circle_rounded,
                                    color: AppColors.successGreen, size: 16),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              meaning,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.volume_up_rounded,
                                color: AppColors.primaryBlue),
                            tooltip: 'Pronounce Word تلفظ سنیں',
                            onPressed: () => AudioService.speakWord(word),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Example Sentence (مثالی جملہ):',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      sentence,
                                      style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      sentenceUrdu,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
