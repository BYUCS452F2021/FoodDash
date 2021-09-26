import 'package:flutter/material.dart';

class CustomTheme {
  static MaterialColor myBlue = const MaterialColor(0xff25CED1, const {
    50: const Color(0xff74e5e7),
    100: const Color(0xff63e1e3),
    200: const Color(0xff52dee0),
    300: const Color(0xff40dbdd),
    400: const Color(0xff2fd7da),
    500: const Color(0xff25CED1),
    600: const Color(0xff22bcbf),
    700: const Color(0xff1fabad),
    800: const Color(0xff1c9a9c),
    900: const Color(0xff18898b)
  });

  static ThemeData get lightTheme {
    //1

    return ThemeData(
      fontFamily: 'Montserrat',
      primarySwatch: myBlue,
      primaryColor: const Color(0xff7CD9F4),
      accentColor: const Color(0xffEA526F), // pink
      buttonColor: const Color(0xffFF8A5B), // coral
      highlightColor: const Color(0xffFF8A5B), // coral
      hoverColor: const Color(0xffFF8A5B), // coral
      backgroundColor: const Color(0xffFCEADE),
      cardTheme: CardTheme(
        color: Colors.white, //const Color(0xffFCEADE),
        elevation: 5,
        margin: EdgeInsets.only(top: 15),
      ),

      textTheme: TextTheme(
        headline1: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 35.0,
          color: Colors.black,
        ),
        headline2: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 45.0,
          color: Colors.white,
        ),
        headline3: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          color: Colors.white,
        ),
        headline4: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20.0,
          color: Colors.black,
        ),
        button: const TextStyle(
          fontFamily: 'Montserrat',
        ),
        subtitle1: const TextStyle(fontFamily: 'Montserrat'),
        bodyText1: const TextStyle(fontFamily: 'Montserrat'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
      ),
    );
  }
}
