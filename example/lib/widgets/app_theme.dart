import 'package:flutter/material.dart';

class AppTheme {
  static const bgDark = Color(0xFF0D1117);
  static const surfaceDark = Color(0xFF161B22);
  static const cardDark = Color(0xFF21262D);
  static const borderDark = Color(0xFF30363D);
  static const primaryBlue = Color(0xFF58A6FF);
  static const primaryAccent = Color(0xFF1F6FEB);
  static const successGreen = Color(0xFF3FB950);
  static const warningAmber = Color(0xFFD29922);
  static const errorRed = Color(0xFFF85149);
  static const textPrimary = Color(0xFFF0F6FC);
  static const textSecondary = Color(0xFF8B949E);
  static const textMuted = Color(0xFF6E7681);

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      cardColor: cardDark,
      dividerColor: borderDark,
      primaryColor: primaryAccent,
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        secondary: primaryAccent,
        surface: surfaceDark,
        error: errorRed,
        onSurface: textPrimary,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
