import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle appBarTextStyle(
      {required double fontSize, required bool isBold, required Color color}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      color: color,
    );
  }

  static TextStyle bodyTextStyle({
    required double fontSize,
    required Color color,
    required FontWeight fontWight,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWight,
      letterSpacing: 1,
      color: color,
    );
  }
}
