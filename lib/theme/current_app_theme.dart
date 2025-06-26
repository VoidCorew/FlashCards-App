import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.indigoAccent),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
  );
}
