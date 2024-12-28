import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/config/constant/app_color.dart';

class AppThemes {
  static final light = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColor.PRIMARY_COLOR,
        onPrimary: AppColor.WHITE,
        secondary: AppColor.SECONDARY_COLOR,
        onSecondary: AppColor.WHITE,
        error: Colors.red,
        onError: Colors.red,
        surface: AppColor.WHITE,
        onSurface: AppColor.BLACK),
    primaryColor: Colors.deepPurple,
    brightness: Brightness.light,
    useMaterial3: true,
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColor.WHITE,
        onPrimary: AppColor.BLACK,
        secondary: AppColor.WHITE,
        onSecondary: AppColor.BLACK,
        error: Colors.red,
        onError: Colors.red,
        surface: AppColor.BLACK,
        onSurface: AppColor.WHITE),
    primaryColor: AppColor.PRIMARY_COLOR,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
