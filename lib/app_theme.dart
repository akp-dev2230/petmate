import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Colors.white,
    //   brightness: Brightness.light,
    // ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 2.0,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: const Color(0xff3E5879),
    //   brightness: Brightness.dark,
    // ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E2433),
      foregroundColor: Colors.white,
      elevation: 2.0
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}
