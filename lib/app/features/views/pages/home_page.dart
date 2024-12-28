import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/components/custom_button/custom_icon_button.dart';
import 'package:flutter_push_notification/app/config/constant/app_color.dart';
import 'package:flutter_push_notification/app/features/views/pages/add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FloatingActionButton(
            backgroundColor: AppColor.PRIMARY_COLOR,
            onPressed: () {},
            child: CustomIconButton(
              icon: FluentSystemIcons.ic_fluent_add_filled,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddTaskPage(),
                  ),
                );
              },
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              child: EasyTheme(
                data: EasyTheme.of(context).copyWith(
                  currentDayBorder: WidgetStatePropertyAll(BorderSide.none),
                  // Background color customization
                  selectionMode: SelectionMode.alwaysFirst(),
                  dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColor
                          .PRIMARY_COLOR; // Selected background color
                    } else if (states.contains(WidgetState.disabled)) {
                      return AppColor
                          .TERTIARY_COLOR; // Disabled background color
                    }
                    return AppColor.TERTIARY_COLOR; // Normal background color
                  }),
                  dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColor.WHITE; // Selected background color
                    } else if (states.contains(WidgetState.disabled)) {
                      return AppColor.WHITE; // Disabled background color
                    }
                    return AppColor.WHITE; // Normal background color
                  }),
                  currentDayBackgroundColor:
                      WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColor
                          .PRIMARY_COLOR; // Selected background color
                    } else if (states.contains(WidgetState.disabled)) {
                      return AppColor
                          .TERTIARY_COLOR; // Disabled background color
                    }
                    return AppColor.TERTIARY_COLOR; // Normal background color
                  }),
                  currentDayForegroundColor:
                      WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColor.WHITE; // Selected background color
                    } else if (states.contains(WidgetState.disabled)) {
                      return AppColor.WHITE; // Disabled background color
                    }
                    return AppColor.WHITE; // Normal background color
                  }),
                ),
                child: EasyDateTimeLinePicker(
                  currentDate: DateTime.now(),
                  focusedDate: _selectedDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
