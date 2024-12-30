// ignore_for_file: avoid_print

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/components/custom_button/custom_default_button.dart';
import 'package:flutter_push_notification/app/components/custom_text_field/custom_drop_down_button.dart';
import 'package:flutter_push_notification/app/components/custom_text_field/text_field.dart';
import 'package:flutter_push_notification/app/features/resources/style/app_color.dart';
import 'package:flutter_push_notification/app/config/constant/constant.dart';
import 'package:flutter_push_notification/app/features/controllers/taskController.dart';
import 'package:flutter_push_notification/app/features/models/taskModel.dart';
import 'package:flutter_push_notification/app/services/notification_services.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());

  DateTime currentDate = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  String selectedTimeReminderRepetition = 'None';
  List<String> timeReminderRepetition = ['None', 'Daily'];

  int selectedTaskColor = 0;
  List<Color> taskColor = [
    AppColor.PRIMARY_COLOR,
    AppColor.BLACK1,
  ];

  //Text controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController reminderController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  //initialize the notificationHelper request for local notification
  NotifyHelper notifyHelper = NotifyHelper();

  // initialize the form key for form validator
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    initializeControllers();
  }

  void initializeControllers() {
    dateController.text =
        AppConstant.formattedDate(currentDate.toString()).toString();
    startTimeController.text = AppConstant.formattedTime(startTime.toString());
    endTimeController.text = AppConstant.formattedTime(endTime.toString());
    reminderController.text = selectedTimeReminderRepetition;
    colorController.text = selectedTaskColor.toString();
  }

  void disposeControllers() {
    titleController.dispose();
    noteController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    reminderController.dispose();
    reminderController.dispose();
    colorController.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  void validateField() {
    if (formKey.currentState!.validate()) {
      addTask(); // add the task to db
      Get.back(); // going back to the corner when I first saw you~~~
    } else {
      Get.snackbar(
        'Required',
        'Please fill all the fields.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
        backgroundColor: AppColor.WHITE,
        icon: Icon(
          FluentSystemIcons.ic_fluent_error_circle_filled,
          color: Colors.red,
        ),
      );
    }
  }

  addTask() async {
    int id = await taskController.addTask(
      task: TaskModel(
        title: titleController.text,
        note: noteController.text,
        date: dateController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        reminder: reminderController.text,
        color: int.parse(colorController.text),
        isCompleted: 0,
      ),
    );
    print('Task with the id of ${id} was created');
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
                    textController: dateController,
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
                          textController: startTimeController,
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
                          textController: endTimeController,
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
                    textController: reminderController,
                    label: 'Reminder',
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
                            children: List<Widget>.generate(taskColor.length,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTaskColor = index;
                                    colorController.text = index.toString();
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
        dateController.text = AppConstant.formattedDate(datePicker.toString());
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
          startTimeController.text =
              AppConstant.formattedTime(formattedPickedTime.toString());
        });
      } else {
        setState(() {
          endTime = formattedPickedTime;
          endTimeController.text =
              AppConstant.formattedTime(formattedPickedTime.toString());
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
            reminderController.text = value.toString();
          },
        );
      },
    );
  }
}
