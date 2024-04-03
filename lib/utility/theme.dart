import 'package:flutter/material.dart';

class Apptheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff3f66c2)),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, foregroundColor: Colors.black),
  );

  static ThemeData DarkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff3f66c2)),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xff1c1d2a),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff1c1d2a), foregroundColor: Colors.white),
  );
}
