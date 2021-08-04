import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

/*
* scaffoldBackgroundColor: main background color
* cardTheme: text container background color
* textTheme: text theme for messages (MessageKind.text)
* outlinedButtonTheme: quick reply button theme (MessageKind.quickReply)
* */

class AppTheme {
  static var light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.lightGreen[30],
    cardTheme: CardTheme(color: Colors.orange[50]),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.sourceCodePro().copyWith(color: Colors.black87),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontWeight: FontWeight.bold))
      ),
    ),
  );

  static var dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black.withOpacity(0.83),
    cardTheme:
        CardTheme(color: Color(0xFF3B3F41), margin: const EdgeInsets.all(8)),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.lato().copyWith(color: Colors.white),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontWeight: FontWeight.bold))
      ),
    ),
  );
}
