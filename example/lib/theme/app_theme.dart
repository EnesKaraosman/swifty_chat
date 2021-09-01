import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

/*
* scaffoldBackgroundColor: main background color
* cardTheme: text container background color
* textTheme: text theme for messages (MessageKind.text)
*   + headline6: carousel title
*   + subtitle2: carousel subtitle
* outlinedButtonTheme: quick reply button theme (MessageKind.quickReply)
* */

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarningColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

mixin AppTheme {
  static ThemeData light(BuildContext context) => ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.lightGreen[30],
    iconTheme: const IconThemeData(color: kContentColorLightTheme),
    // cardTheme: CardTheme(color: kPrimaryColor.withOpacity(0.1)),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorLightTheme),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontWeight: FontWeight.bold))
      ),
    ),
  );

  static ThemeData dark(BuildContext context) => ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    iconTheme: const IconThemeData(color: kContentColorDarkTheme),
    cardTheme: const CardTheme(color: Color(0xFF3B3F41), margin: EdgeInsets.all(8)),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.pink),
        textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontWeight: FontWeight.bold))
      ),
    ),
  );
}
