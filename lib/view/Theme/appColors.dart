import 'package:flutter/material.dart';

enum ThemeModeType { light, dark }

class AppColors {
  static const Color lightBackgroundColor= Color(0xFFE0E0E0);
  static const Color darkBackgroundColor = Color(0xFF212121);

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

  static const int _accentColorValue = 0xFF7D7AFF;
  static const MaterialColor accentColor = MaterialColor(
    _accentColorValue,
    <int, Color>{
      50: Color(0xFFE5E5FF),
      100: Color(0xFFCCCCFF),
      200: Color(0xFFB2B2FF),
      300: Color(0xFF9999FF),
      400: Color(0xFF8080FF),
      500: Color(_accentColorValue),
      600: Color(0xFF6D6DFF),
      700: Color(0xFF5C5CFF),
      800: Color(0xFF4C4CFF),
      900: Color(0xFF3B3BFF),
    },
  );


  // Define light theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor : lightBackgroundColor,
    primaryColor: textColor[900],
    hintColor: accentColor[200],
    canvasColor:accentColor[400] ,
    hoverColor: Colors.white,

    // textTheme:  TextTheme(
    //   bodyMedium: TextStyle(color: textColor[900]),
    // ),
    appBarTheme:  AppBarTheme(
      color: lightBackgroundColor,
      titleTextStyle: TextStyle(color: textColor[800]),
      iconTheme: const IconThemeData(
        color: Colors.transparent,
      ),
    ),
  );

  // Define dark theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor : darkBackgroundColor,
    primaryColor: textColor[50],
    hintColor: accentColor[100],
    canvasColor:accentColor[200] ,
    hoverColor: Colors.white,

    // textTheme: TextTheme(
    //   bodyMedium: TextStyle(color: textColor[50]),
    // ),
    appBarTheme: AppBarTheme(
      // color: accentColor[700],
      color: darkBackgroundColor,
      titleTextStyle: TextStyle(color: textColor[100]),
      iconTheme: const IconThemeData(
        color: Colors.transparent,
      ),
    ),
  );
}

