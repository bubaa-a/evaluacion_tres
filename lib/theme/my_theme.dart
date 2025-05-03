import 'package:flutter/material.dart';

class MyTheme {
  static const Color primary = Color.fromARGB(255, 144, 8, 217);

  static final ThemeData myTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 127, 36, 255),
      brightness: Brightness.light,
      fontFamily: 'Releway',
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 179, 25, 235),
        elevation: 10,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 173, 14, 235))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 184, 80, 222)));
}
