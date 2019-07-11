import 'package:flutter/material.dart';
import 'dart:ui';

class Theme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    accentColor: Colors.grey,
    splashColor: Color(0x551A73E8),
    highlightColor: Color(0x221A73E8),
    primaryColor: Color(0xFF1A73E8),
    primaryColorDark: Color(0xFF5F6368),
    cardColor: Colors.white,
    bottomAppBarColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    cardTheme: CardTheme(
      color: Color(0xFFEEEEEE),
    ),
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.white),
      caption: TextStyle(
        color: Color(0xFF3C4043),
      ),
      button: TextStyle(
        color: Color(0xFF1A73E8),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.grey,
    splashColor: Color(0x558AB4F8),
    highlightColor: Color(0x228AB4F8),
    primaryColor: Color(0xFF8AB4F8),
    primaryColorDark: Color(0xFF9AA0A6),
    cardColor: Color(0xFF2E2F32),
    bottomAppBarColor: Color(0xFF2E2F32),
    scaffoldBackgroundColor: Color(0xFF202124),
    cardTheme: CardTheme(
      color: Color(0xFF1D1E21),
    ),
    textTheme: TextTheme(
      body1: TextStyle(color: Colors.white),
      caption: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
      button: TextStyle(
        color: Color(0xFF8AB4F8),
      ),
    ),
  );
}
