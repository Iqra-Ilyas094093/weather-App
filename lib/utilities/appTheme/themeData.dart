import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_colors/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightCard,
    shadowColor: AppColors.lightShadow,
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightPrimaryText),
        bodyMedium: TextStyle(color: AppColors.lightSecondaryText),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightPrimaryText),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.inter(color: AppColors.lightSecondaryText),
      labelStyle: GoogleFonts.inter(color: AppColors.lightPrimaryText),
      errorStyle: GoogleFonts.inter(color: Colors.redAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.lightSecondaryText),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.sunnyAccent, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.sunnyAccent,
      secondary: AppColors.rainyAccent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    shadowColor: Colors.black54,
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkPrimaryText),
        bodyMedium: TextStyle(color: AppColors.darkSecondaryText),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2C),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.inter(color: AppColors.darkSecondaryText),
      labelStyle: GoogleFonts.inter(color: AppColors.darkPrimaryText),
      errorStyle: GoogleFonts.inter(color: Colors.redAccent),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.darkSecondaryText),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.darkSunnyAccent, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkSunnyAccent,
      secondary: AppColors.darkRainyAccent,
    ),
  );
}
