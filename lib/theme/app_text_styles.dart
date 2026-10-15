import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle gameTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.textDark,
    letterSpacing: 1.2,
  );

  static const TextStyle header = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle subheader = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
  );

  static const TextStyle letterTile = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.tileText,
  );

  static const TextStyle formedWord = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.primaryBlueDark,
    letterSpacing: 3.0,
  );

  static const TextStyle urduText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryBlueDark,
  );

  static const TextStyle statValue = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
}
