// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/components/custom_button/custom_default_button.dart';
import 'package:flutter_push_notification/app/components/tile/task_tile.dart';
import 'package:flutter_push_notification/app/config/constant/constant.dart';
import 'package:flutter_push_notification/app/config/constant/font_size.dart';
import 'package:flutter_push_notification/app/features/resources/style/app_color.dart';
import 'package:flutter_push_notification/app/features/controllers/taskController.dart';
import 'package:flutter_push_notification/app/features/models/taskModel.dart';
import 'package:flutter_push_notification/app/features/resources/style/app_styles.dart';
import 'package:flutter_push_notification/app/features/views/pages/add_task_page.dart';
import 'package:flutter_push_notification/app/services/notification_services.dart';
import 'package:flutter_push_notification/app/services/theme_service.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initialize the notificationHelper request for local notification
  NotifyHelper notifyHelper = NotifyHelper();
  final TaskController taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(() => IconButton(
                onPressed: () {
                  notifyHelper.displayNotification(
                      body: ThemeService().isDarkMode.value
                          ? 'Hello World'
                          : 'GoodBye World',
                      title:
                          'Theme Changed'); //default realtime push notification
                  ThemeService().switchTheme();
                },
                icon: Icon(
                  size: 25,
                  ThemeService().isDarkMode.value
                      ? FluentSystemIcons.ic_fluent_weather_moon_filled
                      : FluentSystemIcons.ic_fluent_weather_sunny_regular,
                ),
              )),
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FloatingActionButton(
          backgroundColor: AppColor.PRIMARY_COLOR,
          onPressed: () async {
            // await addNewTask();
            await Get.to(() => const AddTaskPage());
            taskController.getTasks(); //updates the data
          },
          child: Icon(
            FluentSystemIcons.ic_fluent_add_filled,
            color: AppColor.WHITE,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: Get.isDarkMode
                            ? AppColor.PRIMARY_COLOR
                            : AppColor.LIGHT_COLOR))),
            child: DatePicker(
              DateTime.now(),
              width: 80,
              height: 80,
              monthTextStyle: AppStyles.CALENDAR_TEXT_STYLE,
              dateTextStyle: AppStyles.CALENDAR_TEXT_STYLE
                  .copyWith(fontSize: AppFont.TEXT_3),
              dayTextStyle: AppStyles.CALENDAR_TEXT_STYLE,
              initialSelectedDate: _selectedDate,
              selectionColor: AppColor.PRIMARY_COLOR,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(() {
              if (taskController.taskList.isEmpty) {
                return Center(
                  child: Text(
                    'No tasks available.',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                itemCount: taskController.taskList.length,
                itemBuilder: (context, index) {
                  TaskModel task = taskController.taskList[index];
                  // print(task.toJson());
                  // Handle Daily Tasks and Current Date Task
                  if (task.reminder == 'Daily' &&
                      task.date == _selectedDate.toString()) {
                    try {
                      DateTime date = DateFormat('HH:mm a')
                          .parse(task.startTime.toString());
                      var myTime = DateFormat('HH:mm').format(date);

                      // Schedule notification (move this outside in production)
                      notifyHelper.scheduledNotification(
                        int.parse(myTime.split(':')[0]),
                        int.parse(myTime.split(':')[1]),
                        task,
                      );
                    } catch (e) {
                      print('Error parsing startTime: $e');
                    }
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => showBottomSheet(context, task),
                                child: TaskTile(task),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // Handle Tasks for the Selected Date
                  if (task.date ==
                      AppConstant.formattedDate(_selectedDate.toString())) {
                    try {
                      DateTime date = DateFormat('HH:mm a')
                          .parse(task.startTime.toString());
                      var myTime = DateFormat('HH:mm').format(date);

                      // Schedule notification (move this outside in production)
                      notifyHelper.scheduledNotification(
                        int.parse(myTime.split(':')[0]),
                        int.parse(myTime.split(':')[1]),
                        task,
                      );
                    } catch (e) {
                      print('Error parsing startTime: $e');
                    }
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => showBottomSheet(context, task),
                                child: TaskTile(task),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // No matching tasks for the conditions
                  return const SizedBox.shrink();
                },
              );
            }),
          )
        ],
      ),
    );
  }

  addNewTask() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              backgroundColor:
                  Get.isDarkMode ? AppColor.BLACK1 : AppColor.WHITE,
              contentPadding: const EdgeInsets.all(10),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                          FluentSystemIcons.ic_fluent_ios_arrow_left_filled))
                ],
              ));
        });
  }

  bottomSheetButton(
      {BuildContext? context,
      String? label,
      VoidCallback? onTap,
      Color? color,
      Color? backgroundColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context!).size.width * 0.9,
        child: Text(label!),
      ),
    );
  }

  showBottomSheet(BuildContext context, TaskModel task) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Get.isDarkMode ? AppColor.BLACK1 : AppColor.WHITE),
        padding: const EdgeInsets.only(top: 10),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 80,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      Get.isDarkMode ? AppColor.BLACK2 : AppColor.LIGHT_COLOR),
            ),
            task.isCompleted == 1
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        DefaultButton(
                          label: 'Delete Task',
                          onPressed: () {
                            taskController.delete(task);
                            taskController.getTasks();
                            Get.back();
                          },
                        ),
                        DefaultButton(
                          label: 'Close',
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        DefaultButton(
                          label: 'Task Completed',
                          onPressed: () {
                            taskController
                                .taskCompleted(int.parse(task.id.toString()));
                            taskController.getTasks();
                            Get.back();
                          },
                        ),
                        DefaultButton(
                          label: 'Delete Task',
                          onPressed: () {
                            taskController.delete(task);
                            taskController.getTasks();
                            Get.back();
                          },
                        ),
                        DefaultButton(
                          label: 'Close',
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
