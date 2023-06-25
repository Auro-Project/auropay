import 'package:flutter/material.dart';

enum ThemeModeType { light, dark }

class AppColors {
  static const Color lightBackgroundColor = Colors.white;
  static const Color darkBackgroundColor = Color(0xFF161616);
  static const int _textColorValue = 0xFF262626;

  static const MaterialColor lightTextColor = MaterialColor(
    _textColorValue,
    <int, Color>{
      50: Color(0xFF19191A),   // Darkest shade of black
      100: Color(0xFF2A2A2A),
      200: Color(0xFF262626),
      300: Color(0xFF3B3B3B),
      400: Color(0xFF808080),
      500: Color(_textColorValue),
      600: Color(0xFFB3B3B3),
      700: Color(0xFFD9D9D9),
      800: Color(0xFFE0E0E0),
      900: Color(0xFFF7F7F7),   // Lightest shade of black
    },
  );

  static const int _accent1Value = 0xFF7D7AFF;
  static const MaterialColor accent1 = MaterialColor(
    _accent1Value,
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFE5E5FF),
      200: Color(0xFFCCCCFF),
      300: Color(0xFFB2B2FF),
      400: Color(0xFF9999FF),
      500: Color(_accent1Value),
      600: Color(0xFF8080FF),
      700: Color(0xFF6D6DFF),
      800: Color(0xFF5C5CFF),
      900: Color(0xFF4C4CFF),
    },
  );

  static Color grey = Colors.grey.withOpacity(0.25);

  // Define light theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightBackgroundColor,
    primaryColor: lightBackgroundColor,
    hintColor: accent1,
    cardColor: lightTextColor[900],   // Use darkest shade of black as card color
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),   // Set text color to black
    ),
    appBarTheme: const AppBarTheme(
      color: lightBackgroundColor,
      titleTextStyle: TextStyle(color: Colors.black),   // Set app bar text color to black
      iconTheme: IconThemeData(
        color: accent1,
      ),
    ),
  );

  // Define dark theme
  static const MaterialColor darkTextColor = MaterialColor(
    _textColorValue,
    <int, Color>{
      50: Color(0xFFF7F7F7),   // Lightest shade of black
      100: Color(0xFFE0E0E0),
      200: Color(0xFFD9D9D9),
      300: Color(0xFFB3B3B3),
      400: Color(0xFF808080),
      500: Color(_textColorValue),
      600: Color(0xFF3B3B3B),
      700: Color(0xFF262626),
      800: Color(0xFF2A2A2A),
      900: Color(0xFF19191A),   // Darkest shade of black
    },
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkBackgroundColor,
    primaryColor: darkBackgroundColor,
    hintColor: accent1[200],
    cardColor: darkTextColor[50],   // Use lightest shade of black as card color
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),   // Set text color to white
    ),
    appBarTheme: AppBarTheme(
      color: accent1[700],
      titleTextStyle: const TextStyle(color: Colors.white),   // Set app bar text color to white
      iconTheme: IconThemeData(
        color: accent1[200],
      ),
    ),
  );
}