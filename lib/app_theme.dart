import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 22 : 18;

    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2.0,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 22 : 18;

    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E2433),
        foregroundColor: Colors.white,
        elevation: 2.0,
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    );
  }
}
