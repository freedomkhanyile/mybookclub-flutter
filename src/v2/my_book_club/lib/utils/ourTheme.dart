import 'package:flutter/material.dart';

class OurTheme {
  Color _cloud = HexColor("#FFFFFF");
  Color _grey = HexColor("#94989B");
  Color _black = HexColor("#000000");
  Color _lightGreen = HexColor("#83BF4F");
  Color _darkGreen = HexColor("#699635");
  double _borderRadius = 6.0;
  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _cloud,
      primaryColor: _lightGreen,
      accentColor: _black,
      secondaryHeaderColor: _grey, 
      hintColor: _grey,
      inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide(
          color: _grey
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        borderSide: BorderSide(
          color: _lightGreen
        )
      )),
      buttonTheme: ButtonThemeData(
         buttonColor: _lightGreen,
         padding: EdgeInsets.symmetric(horizontal: 20.0),
         minWidth: 150,
         height: 50,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(_borderRadius),),
      )
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}