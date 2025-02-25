import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth > 600 ? 22 : 18;

    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF452c63),
        elevation: 2.0,
      ),
      useMaterial3: true,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
        bodySmall: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}