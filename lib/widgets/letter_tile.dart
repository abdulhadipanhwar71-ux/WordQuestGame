import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class LetterTile extends StatelessWidget {
  final String letter;
  final bool isSelected;
  final VoidCallback onTap;
  final double size;

  const LetterTile({
    Key? key,
    required this.letter,
    required this.isSelected,
    required this.onTap,
    this.size = 64.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      width: size,
      height: size,
      transform:
          isSelected ? (Matrix4.identity()..scale(0.92)) : Matrix4.identity(),
      child: Material(
        color: isSelected ? AppColors.tileSelected : AppColors.tileBackground,
        elevation: isSelected ? 1 : 4,
        borderRadius: BorderRadius.circular(16),
        shadowColor: Colors.black26,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.primaryBlueLight.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.goldCoin : AppColors.tileBorder,
                width: isSelected ? 2.5 : 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: AppTextStyles.letterTile.copyWith(
                color:
                    isSelected ? AppColors.primaryBlueDark : AppColors.tileText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
