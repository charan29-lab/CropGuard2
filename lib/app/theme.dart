import 'package:flutter/material.dart';

class CropGuardColors {
  static const primary = Color(0xFF166534);
  static const secondary = Color(0xFF22C55E);

  static const background = Color(0xFFF8FAF8);
  static const surface = Color(0xFFFFFFFF);

  static const textPrimary = Color(0xFF17201A);
  static const textSecondary = Color(0xFF66736A);

  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFDC2626);

  static const border = Color(0xFFDDE5DE);
}

class CropGuardTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: CropGuardColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: CropGuardColors.primary,
      brightness: Brightness.light,
    ),

    fontFamily: 'Inter',

    appBarTheme: const AppBarTheme(
      backgroundColor: CropGuardColors.background,
      foregroundColor: CropGuardColors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),

    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: CropGuardColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: CropGuardColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: CropGuardColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: CropGuardColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: CropGuardColors.textSecondary,
      ),
    ),
  );
}