// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/features/resources/style/app_color.dart';
import 'package:flutter_push_notification/app/config/constant/font_size.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle TEXT_STYLE1 =
      GoogleFonts.lato(fontSize: AppFont.TEXT_2, color: AppColor.LIGHT_COLOR);

  static TextStyle CALENDAR_TEXT_STYLE = GoogleFonts.poppins(
    fontSize: AppFont.TEXT_1,
  );
}
