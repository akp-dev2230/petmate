import 'package:flutter/cupertino.dart';
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
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: fontSize, color: Colors.black),
        bodyMedium: const TextStyle(fontSize: 16, color: Colors.black54)
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: CupertinoColors.systemGrey6,
      )
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
      ),
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: fontSize, color: Colors.white),
        bodyMedium: const TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Color(0xFF2b2f3d),
      )
    );
  }
}
