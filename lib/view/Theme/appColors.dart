import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFE5E5E5);
  static const Color textColor = Color(0xFF262626);
  static const Color accent1 = Color(0xFF7D7AFF);
  static Color grey = Colors.grey.withOpacity(0.25);
  // Define other colors here

  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textColor),
    ),
    // Define other light theme properties
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    // Define other dark theme properties
  );
}
