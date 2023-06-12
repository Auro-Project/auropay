import 'package:flutter/material.dart';

import 'appColors.dart';

enum ThemeModeType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.light;

  ThemeData getTheme() {
    return _themeMode == ThemeModeType.light
        ? AppColors.lightTheme
        : AppColors.darkTheme;
  }

  ThemeMode getThemeMode() {
    return _themeMode == ThemeModeType.light ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeModeType.light
        ? ThemeModeType.dark
        : ThemeModeType.light;
    notifyListeners();
  }
}
