import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true; // Set the initial dark mode state

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  Color get backgroundColor {
    return _isDarkMode ? const Color(0xFF161616) : Colors.white;
  }

  Color get textColor {
    return _isDarkMode ? Colors.white : Colors.black;
  }

  ThemeData get theme {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: textColor,
            fontFamily: 'SF Pro Display',
        ),
        // Customize more text styles for dark theme as needed
      ),
    )
        : ThemeData.light().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: textColor,
            fontFamily: 'SF Pro Display',
        ),
        // Customize more text styles for light theme as needed
      ),
    );
  }
}
