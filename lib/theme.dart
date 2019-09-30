import 'package:flutter/material.dart';


class ThemeAndroid {
  static ThemeData light = ThemeData(
    platform: TargetPlatform.android,
    primaryColorLight: Colors.green,
    backgroundColor: Colors.orange,
    errorColor: Colors.red,
    brightness: Brightness.light,
    dividerColor: Color(0xFFEEEEEE),
    toggleableActiveColor: Color(0xFF1A73E8),
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
      caption: TextStyle(
        color: Color(0xFF3C4043),
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      subhead: TextStyle(
        color: Color(0xFF3C4043).withAlpha(180),
        fontFamily: "Roboto",
        fontSize: 12.8,
      ),
      title: TextStyle(
        color: Colors.grey[800],
        fontFamily: "Roboto",
        fontSize: 15,
      ),
      subtitle: TextStyle(
        color: Colors.grey[600],
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: 12.2,
      ),
      body1: TextStyle(
        color: Colors.grey[800],
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      button: TextStyle(
        fontSize: 17,
        fontFamily: "Roboto",
        color: Color(0xFF1A73E8),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    platform: TargetPlatform.android,
    primaryColorLight: Colors.greenAccent,
    backgroundColor: Colors.orangeAccent,
    errorColor: Colors.redAccent,
    brightness: Brightness.dark,
    accentColor: Colors.grey,
    toggleableActiveColor: Color(0xFF8AB4F8),
    dividerColor: Color(0xFF1D1E21),
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
      caption: TextStyle(
        color: Colors.grey[100],
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      subhead: TextStyle(
        color: Colors.grey[100].withAlpha(180),
        fontFamily: "Roboto",
        fontSize: 12.8,
      ),
      title: TextStyle(
        color: Colors.grey[200],
        fontFamily: "Roboto",
        fontSize: 15,
      ),
      subtitle: TextStyle(
        color: Colors.grey[400],
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: 12.2,
      ),
      body1: TextStyle(
        color: Colors.grey[200],
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      button: TextStyle(
        fontSize: 17,
        fontFamily: "Roboto",
        color: Color(0xFF8AB4F8),
      ),
    ),
  );
}

class ThemeIOS {
  static ThemeData light = ThemeData(
    platform: TargetPlatform.iOS,
    primaryColorLight: Colors.green,
    backgroundColor: Colors.orange,
    errorColor: Colors.red,
    brightness: Brightness.light,
    dividerColor: Color(0xFFE8E6E9),
    toggleableActiveColor: Color(0xFF1A73E8),
    accentColor: Colors.grey,
    splashColor: Color(0x551A73E8),
    highlightColor: Color(0x221A73E8),
    primaryColor: Color(0xFF197CF8),
    primaryColorDark: Color(0xFF61616A),
    cardColor: Colors.white,
    bottomAppBarColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFFF7F7F7),
    cardTheme: CardTheme(
      elevation: 0,
      color: Color(0xFFFFFFFF),
    ),
    textTheme: TextTheme(
      caption: TextStyle(
        color: Color(0xFF3C4043),
        fontFamily: "SFUIText-Semibold",
        fontSize: 18,
      ),
      subhead: TextStyle(
        color: Color(0xFF3C4043).withAlpha(180),
        fontFamily: "SFUIText-Semibold",
        fontSize: 12,
      ),
      title: TextStyle(
        color: Colors.grey[800],
        fontFamily: "SFUIText-Semibold",
        fontSize: 14,
      ),
      subtitle: TextStyle(
        color: Colors.grey[600],
        fontFamily: "SFUIText-Regular",
        fontSize: 12,
      ),
      body1: TextStyle(
        color: Colors.grey[800],
        fontFamily: "SFUIText-Semibold",
        fontSize: 16,
      ),
      button: TextStyle(
        fontSize: 17,
        fontFamily: "SFUIText-Semibold",
        color: Color(0xFF1A73E8),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    platform: TargetPlatform.iOS,
    primaryColorLight: Colors.greenAccent,
    backgroundColor: Colors.orangeAccent,
    errorColor: Colors.redAccent,
    brightness: Brightness.dark,
    accentColor: Colors.grey,
    toggleableActiveColor: Color(0xFF8AB4F8),
    dividerColor: Color(0xFF1D1E21),
    splashColor: Color(0x558AB4F8),
    highlightColor: Color(0x228AB4F8),
    primaryColor: Color(0xFF8AB4F8),
    primaryColorDark: Color(0xFF9AA0A6),
    cardColor: Color(0xFF2C2C2E),
    bottomAppBarColor: Color(0xFF2C2C2E),
    scaffoldBackgroundColor: Color(0xFF1C1C1E),
    cardTheme: CardTheme(
      color: Color(0xFF1D1E21),
    ),
    textTheme: TextTheme(
      caption: TextStyle(
        color: Colors.grey[100],
        fontFamily: "SFUIText-Semibold",
        fontSize: 18,
      ),
      subhead: TextStyle(
        color: Colors.grey[100].withAlpha(180),
        fontFamily: "SFUIText-Semibold",
        fontSize: 12,
      ),
      title: TextStyle(
        color: Colors.grey[200],
        fontFamily: "SFUIText-Semibold",
        fontSize: 14,
      ),
      subtitle: TextStyle(
        color: Colors.grey[400],
        fontFamily: "SFUIText-Regular",
        fontSize: 12,
      ),
      body1: TextStyle(
        color: Colors.grey[200],
        fontFamily: "SFUIText-Semibold",
        fontSize: 16,
      ),
      button: TextStyle(
        fontSize: 17,
        fontFamily: "SFUIText-Semibold",
        color: Color(0xFF8AB4F8),
      ),
    ),
  );
}
