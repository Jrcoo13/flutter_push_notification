// ignore_for_file: avoid_print

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/components/custom_button/custom_default_button.dart';
import 'package:flutter_push_notification/app/components/custom_text_field/custom_drop_down_button.dart';
import 'package:flutter_push_notification/app/components/custom_text_field/text_field.dart';
import 'package:flutter_push_notification/app/config/constant/app_color.dart';
import 'package:flutter_push_notification/app/config/constant/constant.dart';
import 'package:flutter_push_notification/app/services/notification_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime currentDate = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  int selectedTimeReminder = 5;
  List<int> timeReminder = [5, 10, 15, 20, 25];

  String selectedTimeReminderRepetition = 'None';
  List<String> timeReminderRepetition = ['None', 'Daily', 'Weekly', 'Monthly'];

  int selectedTaskColor = 0;
  List<Color> taskColor = [
    Colors.deepPurple.shade400,
    Colors.blue.shade400,
    Colors.green.shade400
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  NotifyHelper notifyHelper = NotifyHelper();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  void validateField() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextField(
                    textController: titleController,
                    label: 'Title',
                    isReadOnly: false,
                    placeholder: 'Enter your title',
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return '*This field is required';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    textController: noteController,
                    label: 'Note',
                    isReadOnly: false,
                    placeholder: 'Enter your note',
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return '*This field is required';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    label: 'Date',
                    isReadOnly: true,
                    placeholder:
                        AppConstant.formattedDate(currentDate.toString())
                            .toString(),
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return '*This field is required';
                      }
                      return null;
                    },
                    trailingIcon: FluentSystemIcons.ic_fluent_calendar_regular,
                    onPressed: () {
                      getDateTimeUser(context);
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          label: 'Start Time',
                          isReadOnly: true,
                          placeholder:
                              AppConstant.formattedTime(startTime.toString()),
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return '*This field is required';
                            }
                            return null;
                          },
                          trailingIcon:
                              FluentSystemIcons.ic_fluent_timer_regular,
                          onPressed: () => getTaskTime(isStartTime: true),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MyTextField(
                          label: 'End Time',
                          isReadOnly: true,
                          placeholder:
                              AppConstant.formattedTime(endTime.toString()),
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return '*This field is required';
                            }
                            return null;
                          },
                          trailingIcon:
                              FluentSystemIcons.ic_fluent_timer_off_regular,
                          onPressed: () => getTaskTime(isStartTime: false),
                        ),
                      ),
                    ],
                  ),
                  CustomDropDownButton(
                    label: 'Reminder',
                    isReadOnly: true,
                    placeholder: "$selectedTimeReminder minutes",
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return '*This field is required';
                      }
                      return null;
                    },
                    widget: showReminder(),
                  ),
                  CustomDropDownButton(
                    label: 'Repetition',
                    isReadOnly: true,
                    placeholder: selectedTimeReminderRepetition,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return '*This field is required';
                      }
                      return null;
                    },
                    widget: showReminderTimer(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Color'),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: List<Widget>.generate(3, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTaskColor = index;
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor: taskColor[index],
                                      ),
                                    ),
                                    selectedTaskColor == index
                                        ? Positioned(
                                            top: 4,
                                            left: 4,
                                            child: Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_checkmark_filled,
                                              color: AppColor.WHITE,
                                              size: 20,
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: DefaultButton(
                          label: 'Add Task',
                          onPressed: () {
                            validateField();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getDateTimeUser(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (datePicker != null) {
      setState(() {
        currentDate = datePicker;
      });
    }
  }

  getTaskTime({required bool isStartTime}) async {
    var pickTime = await _showTimePicker(context);
    if (pickTime != null) {
      // Combine the picked time with the current date
      final now = DateTime.now();
      final formattedPickedTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickTime.hour,
        pickTime.minute,
      );

      if (isStartTime) {
        setState(() {
          startTime = formattedPickedTime;
        });
      } else {
        setState(() {
          endTime = formattedPickedTime;
        });
      }
    } else {
      // Handle if the user cancels the time picker
      print("Time picker was canceled.");
    }
  }

  Future<TimeOfDay?> _showTimePicker(BuildContext context) {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
          hour: int.parse(AppConstant.getHour(startTime.toString())),
          minute: int.parse(AppConstant.getMinutes(startTime.toString()))),
    );
  }

  showReminder() {
    return DropdownButton(
      padding: const EdgeInsets.only(right: 10),
      icon: Icon(
        FluentSystemIcons.ic_fluent_chevron_down_filled,
        color: AppColor.LIGHT_COLOR,
      ),
      elevation: 4,
      underline: Container(
        height: 0,
      ),
      items: timeReminder.map<DropdownMenuItem<String>>((int value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(
            value.toString(),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(
          () {
            selectedTimeReminder = int.parse(value.toString());
          },
        );
      },
    );
  }

  showReminderTimer() {
    return DropdownButton(
      padding: const EdgeInsets.only(right: 10),
      icon: Icon(
        FluentSystemIcons.ic_fluent_chevron_down_filled,
        color: AppColor.LIGHT_COLOR,
      ),
      elevation: 4,
      underline: Container(
        height: 0,
      ),
      items:
          timeReminderRepetition.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(
            value.toString(),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(
          () {
            selectedTimeReminderRepetition = value.toString();
          },
        );
      },
    );
  }
}
