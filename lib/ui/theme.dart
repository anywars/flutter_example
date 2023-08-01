import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExTheme {
  static light({bool? useMaterial3, Brightness? brightness}) => ThemeData(
    useMaterial3: useMaterial3,
    brightness: brightness ?? Brightness.light,

    // colorScheme: ColorScheme.light(
    // ),

    textTheme: TextTheme(
      headlineSmall: GoogleFonts.abel(fontSize: 20),
      headlineMedium: GoogleFonts.abel(fontSize: 40),
      headlineLarge: GoogleFonts.abel(fontSize: 60),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: Size.fromHeight(40),
      )
    ),


  );

  static dark({bool? useMaterial3}) => light(
    brightness: Brightness.dark,
    useMaterial3: useMaterial3,
  );

  // factory ExTheme.light({bool? useMaterial3}) => ThemeData(
  //   brightness: Brightness.light,
  //   useMaterial3: useMaterial3,
  // );

}