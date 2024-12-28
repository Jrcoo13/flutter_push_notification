// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class AppColor {
  static const Color PRIMARY_COLOR = Color(0xFF0A2647);
  static const Color SECONDARY_COLOR = Color(0xFF144272);
  static const Color TERTIARY_COLOR = Color(0xFF205295);
  static const Color ANOTHER_COLOR = Color(0xFF2C74B3);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLACK = Color(0xFF000000);
  static const Color LIGHT_COLOR = Color(0xFFA6AEBF);
  static final Color BLACK1 = HexColor('#18191A');
  static final Color BLACK2 = HexColor('#242526');
  static final Color BLACK3 = HexColor('#3A3B3C');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
