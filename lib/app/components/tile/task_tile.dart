// ignore_for_file: deprecated_member_use

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/config/constant/font_size.dart';
import 'package:flutter_push_notification/app/features/resources/style/app_color.dart';
import 'package:flutter_push_notification/app/features/models/taskModel.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final TaskModel? task;
  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "",
                  style: GoogleFonts.montserrat(
                      decoration: task!.isCompleted == 1
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: AppFont.TEXT_3,
                      fontWeight: AppFont.FW_3),
                ),
                Text(
                  task?.note ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: AppColor.WHITE),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FluentSystemIcons.ic_fluent_clock_regular,
                      color: AppColor.LIGHT_COLOR,
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 13, color: AppColor.LIGHT_COLOR),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 1,
            color: AppColor.LIGHT_COLOR,
          ),
          // RotatedBox(
          //   quarterTurns: 3,
          //   child: Text(
          //     task!.isCompleted == 1 ? "COMPLETED" : "TODO",
          //     style: GoogleFonts.lato(
          //       textStyle: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white),
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return AppColor.PRIMARY_COLOR;
      case 1:
        return AppColor.BLACK1;
      default:
        return AppColor.PRIMARY_COLOR;
    }
  }
}
