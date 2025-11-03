//  lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:hime/core/theme/pallete.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Pallete.primaryColor,
    scaffoldBackgroundColor: Pallete.backgroundColor,
    canvasColor: Pallete.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: Pallete.primaryColor,
      secondary: Pallete.secondaryColor,
      surface: Pallete.whiteColor,
      background: Pallete.backgroundColor,
      error: Pallete.errorColor,
      onPrimary: Pallete.whiteColor,
      onSecondary: Pallete.whiteColor,
      onSurface: Color(0xFF1C1B1F),
      onBackground: Color(0xFF1C1B1F),
      onError: Pallete.whiteColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.primaryColor,
      foregroundColor: Pallete.whiteColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Pallete.whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.primaryColor,
        foregroundColor: Pallete.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Pallete.primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Pallete.whiteColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Pallete.greyColor, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Pallete.primaryColor, width: 2),
      ),
      hintStyle: TextStyle(color: Pallete.greyColor.withOpacity(0.7)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1C1B1F),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1C1B1F),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1C1B1F),
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF1C1B1F)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF1C1B1F)),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Pallete.whiteColor,
      ),
    ),

    iconTheme: const IconThemeData(color: Pallete.primaryColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.whiteColor,
      selectedItemColor: Pallete.primaryColor,
      unselectedItemColor: Pallete.greyColor,
    ),
  );
}
