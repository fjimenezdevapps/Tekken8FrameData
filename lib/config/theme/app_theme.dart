import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      //useMaterial3: false,
      colorScheme: const ColorScheme(
        primary: Color(0xFFE50914),
        primaryContainer: Color(0xFFB71C1C),
        secondary: Color(0xFF0D1B2A),
        secondaryContainer: Color(0xFF1B263B),
        surface: Color(0xFF1C1C1C),
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        headlineSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF0D1B2A),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}