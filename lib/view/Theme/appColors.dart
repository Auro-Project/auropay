import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF1F1F1);
  static const int _textColorValue = 0xFF262626;

  static const MaterialColor textColor = MaterialColor(
    _textColorValue,
    <int, Color>{
      50: Color(0xFFE0E0E0),
      100: Color(0xFFB3B3B3),
      200: Color(0xFF808080),
      300: Color(0xFF4D4D4D),
      400: Color(0xFF262626),
      500: Color(_textColorValue),
      600: Color(0xFF1F1F1F),
      700: Color(0xFF191919),
      800: Color(0xFF121212),
      900: Color(0xFF0C0C0C),
    },
  );

  static const int _accent1Value = 0xFF7D7AFF;
  static const MaterialColor accent1 = MaterialColor(
    _accent1Value,
    <int, Color>{
      50: Color(0xFFE5E5FF),
      100: Color(0xFFCCCCFF),
      200: Color(0xFFB2B2FF),
      300: Color(0xFF9999FF),
      400: Color(0xFF8080FF),
      500: Color(_accent1Value),
      600: Color(0xFF6D6DFF),
      700: Color(0xFF5C5CFF),
      800: Color(0xFF4C4CFF),
      900: Color(0xFF3B3BFF),
    },
  );

  static Color grey = Colors.grey.withOpacity(0.25);

  // Define light theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    hintColor: accent1,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textColor),
    ),
    appBarTheme: AppBarTheme(
      color: primaryColor,
      titleTextStyle: TextStyle(color: textColor),
      iconTheme: IconThemeData(
        color: accent1,
      ),
    ),
  );

  // Define dark theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: accent1[700],
    hintColor: accent1[200],
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textColor[50]),
    ),
    appBarTheme: AppBarTheme(
      color: accent1[700],
      titleTextStyle: TextStyle(color: textColor),
      iconTheme: IconThemeData(
        color: accent1[200],
      ),
    ),
  );
}
