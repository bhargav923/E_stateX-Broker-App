import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      error: AppColors.error,
    ),

    // Scaffold
    scaffoldBackgroundColor: AppColors.background,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Text
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
      ),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(
          color: AppColors.primary,
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.border,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),

      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
      ),

      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
      ),
    ),

    // Card
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppColors.border,
        ),
      ),
      margin: EdgeInsets.zero,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // Icon
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: 24,
    ),

    // Floating Action Button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 2,
    ),
  );
}