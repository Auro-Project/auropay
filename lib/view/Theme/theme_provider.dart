import 'package:flutter/material.dart';
import 'package:auropay/view/Theme/appColors.dart';

enum ThemeModeType { light, dark }

class ThemeProvider with ChangeNotifier {
  final ThemeData _lightTheme = ThemeData.light();
  final ThemeData _darkTheme = ThemeData.dark();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeData getTheme() {
    return _themeMode == ThemeMode.light ? _lightTheme : _darkTheme;
  }

  ThemeMode getThemeMode() {
    return _themeMode;
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}



