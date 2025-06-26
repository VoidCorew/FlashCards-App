import 'package:flutter/material.dart';

/// Define a centralized color palette for light and dark modes.
class AppColors {
  // Light theme colors
  static const Color lightPrimary = Color(0xFF4CAF50); // Green
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightPrimaryContainer = Color(0xFFA5D6A7);
  static const Color lightOnPrimaryContainer = Color(0xFF1B5E20);
  static const Color lightSecondary = Color(0xFFFFC107); // Amber
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightSecondaryContainer = Color(0xFFFFECB3);
  static const Color lightOnSecondaryContainer = Color(0xFF3E2723);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightError = Color(0xFFD32F2F);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightOutline = Color(0xFFBDBDBD);
  static const Color lightSurfaceContainer = Color(0xFFF1F8E9);

  // Dark theme colors
  static const Color darkPrimary = Color(0xFF81C784); // Light green
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkPrimaryContainer = Color(0xFF388E3C);
  static const Color darkOnPrimaryContainer = Color(0xFFC8E6C9);
  static const Color darkSecondary = Color(0xFFFFD54F); // Soft amber
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkSecondaryContainer = Color(0xFFFFB300);
  static const Color darkOnSecondaryContainer = Color(0xFFFFF8E1);
  static const Color darkSurface = Color(0xFF2E7D32);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkOnError = Color(0xFF000000);
  static const Color darkOutline = Color(0xFF757575);
  static const Color darkSurfaceContainer = Color(0xFF1B5E20);
}

/// Generates light ThemeData
ThemeData buildLightTheme() {
  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightOnPrimary,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightOnSecondary,
      secondaryContainer: AppColors.lightSecondaryContainer,
      onSecondaryContainer: AppColors.lightOnSecondaryContainer,
      error: AppColors.lightError,
      onError: AppColors.lightOnError,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      outline: AppColors.lightOutline,
      shadow: Colors.black,
      scrim: Colors.black45,
      inverseSurface: Colors.grey[800]!,
      onInverseSurface: Colors.white,
      inversePrimary: AppColors.lightSecondary,
      surfaceTint: AppColors.lightPrimary,
      surfaceContainer: AppColors.lightSurfaceContainer,
    ),
    scaffoldBackgroundColor: AppColors.lightSurfaceContainer,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightOnPrimary,
        backgroundColor: AppColors.lightPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.lightPrimary),
    ),
  );
}

/// Generates dark ThemeData
ThemeData buildDarkTheme() {
  return ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkOnPrimary,
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkOnSecondary,
      secondaryContainer: AppColors.darkSecondaryContainer,
      onSecondaryContainer: AppColors.darkOnSecondaryContainer,
      error: AppColors.darkError,
      onError: AppColors.darkOnError,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      outline: AppColors.darkOutline,
      shadow: Colors.black,
      scrim: Colors.black45,
      inverseSurface: Colors.grey[100]!,
      onInverseSurface: Colors.black,
      inversePrimary: AppColors.darkSecondary,
      surfaceTint: AppColors.darkPrimary,
      surfaceContainer: AppColors.darkSurfaceContainer,
    ),
    scaffoldBackgroundColor: AppColors.darkSurfaceContainer,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.darkOnPrimary,
        backgroundColor: AppColors.darkPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.darkSecondary),
    ),
  );
}
