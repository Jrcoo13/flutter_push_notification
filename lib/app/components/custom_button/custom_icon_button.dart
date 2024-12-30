import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/features/resources/style/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const CustomIconButton(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
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
          Icon(
            icon,
          ),
        ],
      ),
    );
  }
}
