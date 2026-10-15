import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CurrentWordDisplay extends StatelessWidget {
  final String word;
  final VoidCallback onBackspace;
  final VoidCallback onClear;

  const CurrentWordDisplay({
    Key? key,
    required this.word,
    required this.onBackspace,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: word.isNotEmpty ? AppColors.primaryBlue : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.clear_rounded, color: Colors.grey),
            tooltip: 'Clear',
            onPressed: word.isNotEmpty ? onClear : null,
          ),
          Expanded(
            child: Text(
              word.isEmpty ? 'TAP LETTERS BELOW' : word,
              textAlign: TextAlign.center,
              style: word.isEmpty
                  ? TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.grey.shade400,
                    )
                  : AppTextStyles.formedWord,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.backspace_rounded,
                color: AppColors.primaryBlue),
            tooltip: 'Backspace',
            onPressed: word.isNotEmpty ? onBackspace : null,
          ),
        ],
      ),
    );
  }
}
