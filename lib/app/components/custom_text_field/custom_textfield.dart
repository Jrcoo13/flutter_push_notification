import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/config/constant/app_color.dart';
import 'package:flutter_push_notification/app/config/constant/font_size.dart';
import 'package:get/get.dart';

class CustomTextfield extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  const CustomTextfield(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.widget,
      this.onPressed,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: !Get.isDarkMode ? AppColor.WHITE : AppColor.BLACK,
                border: Border.all(
                    width: 1,
                    color: !Get.isDarkMode
                        ? AppColor.LIGHT_COLOR
                        : AppColor.BLACK2),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: onPressed,
                    controller: controller,
                    readOnly: widget != null ? true : false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*This field is required';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    autofocus: false,
                    style: TextStyle(fontSize: AppFont.TEXT_2),
                    decoration: InputDecoration(
                      hintText: hintText,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                widget != null
                    ? Container(
                        child: widget,
                      )
                    : SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
    );
  }
}
