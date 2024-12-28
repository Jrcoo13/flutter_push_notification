import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/config/constant/app_color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDownButton extends StatefulWidget {
  final TextEditingController? textController;
  final String? placeholder;
  final String label;
  final bool isReadOnly;
  final Widget widget;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  const CustomDropDownButton(
      {super.key,
      this.textController,
      required this.label,
      required this.validator,
      required this.isReadOnly,
      this.onPressed,
      this.placeholder,
      required this.widget});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            onTap: widget.onPressed,
            autofocus: false,
            readOnly: widget.isReadOnly,
            controller: widget.textController,
            autocorrect: false,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w400),
                filled: true, // Apply background color to TextFormField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      width: 1,
                      color: !Get.isDarkMode
                          ? AppColor.LIGHT_COLOR
                          : AppColor.BLACK2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1,
                      color: !Get.isDarkMode
                          ? AppColor.LIGHT_COLOR
                          : AppColor.BLACK2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      width: 1.5,
                      color: !Get.isDarkMode
                          ? AppColor.LIGHT_COLOR
                          : AppColor.BLACK2),
                ),
                suffixIcon: widget.widget),
          ),
        ],
      ),
    );
  }
}
