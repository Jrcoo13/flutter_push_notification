import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/config/constant/app_color.dart';
import 'package:flutter_push_notification/app/config/constant/font_size.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const DefaultButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding:
            WidgetStatePropertyAll(const EdgeInsets.symmetric(vertical: 12)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        iconColor: WidgetStatePropertyAll(AppColor.WHITE),
        foregroundColor: WidgetStatePropertyAll(AppColor.WHITE),
        backgroundColor: WidgetStatePropertyAll(AppColor.PRIMARY_COLOR),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(
                fontSize: AppFont.TEXT_3, fontWeight: AppFont.FW_2),
          ),
        ],
      ),
    );
  }
}
