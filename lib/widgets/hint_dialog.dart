import 'package:flutter/material.dart';
import '../data/scoring_config.dart';
import '../game/hint_system.dart';
import '../theme/app_colors.dart';

class HintDialog extends StatelessWidget {
  final int currentCoins;
  final Function(HintType type) onSelectHint;

  const HintDialog({
    Key? key,
    required this.currentCoins,
    required this.onSelectHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '💡 School Hints',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.goldCoin.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on_rounded,
                          color: AppColors.goldCoin, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '$currentCoins',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Select a hint to uncover undiscovered words:',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            _buildHintTile(
              context: context,
              icon: Icons.title_rounded,
              title: 'Reveal First Letter',
              titleUrdu: 'پہلا حرف ظاہر کریں',
              cost: ScoringConfig.costRevealFirstLetter,
              type: HintType.firstLetter,
            ),
            const SizedBox(height: 10),
            _buildHintTile(
              context: context,
              icon: Icons.straighten_rounded,
              title: 'Reveal Word Length',
              titleUrdu: 'لفظ کے حروف کی تعداد بتائیں',
              cost: ScoringConfig.costRevealWordLength,
              type: HintType.wordLength,
            ),
            const SizedBox(height: 10),
            _buildHintTile(
              context: context,
              icon: Icons.translate_rounded,
              title: 'Reveal Urdu Meaning',
              titleUrdu: 'اردو مفہوم کا اشارہ دیکھیں',
              cost: ScoringConfig.costRevealUrduMeaning,
              type: HintType.urduMeaning,
            ),
            const SizedBox(height: 10),
            _buildHintTile(
              context: context,
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Sentence Clue',
              titleUrdu: 'مثالی جملے کا اشارہ دیکھیں',
              cost: ScoringConfig.costRevealSentenceClue,
              type: HintType.sentenceClue,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHintTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String titleUrdu,
    required int cost,
    required HintType type,
  }) {
    final canAfford = currentCoins >= cost;
    return Material(
      color: canAfford ? Colors.grey.shade50 : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: canAfford
            ? () {
                Navigator.pop(context);
                onSelectHint(type);
              }
            : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: canAfford
                  ? AppColors.primaryBlue.withOpacity(0.3)
                  : Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: canAfford ? AppColors.primaryBlue : Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: canAfford ? Colors.black87 : Colors.grey,
                      ),
                    ),
                    Text(
                      titleUrdu,
                      style: TextStyle(
                        fontSize: 12,
                        color: canAfford ? AppColors.primaryBlue : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: canAfford ? AppColors.goldCoin : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      size: 14,
                      color: canAfford ? Colors.white : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '$cost',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: canAfford ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
