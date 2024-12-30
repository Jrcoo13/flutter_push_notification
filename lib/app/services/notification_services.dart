// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_push_notification/app/features/models/taskModel.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    // Uncomment if you need to initialize time zones
    // tz.initializeTimeZones();
    configureLocalTimezone();

    // iOS initialization settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    // Android initialization settings
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    // Combine settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin
    try {
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: selectNotification);
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Display a dialog with the notification details
    Get.dialog(
      AlertDialog(
        title: Text(title ?? 'Notification'),
        content: Text(body ?? 'You have a new notification.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<dynamic> selectNotification(NotificationResponse response) async {
    // Handle the notification response
    if (response.payload != null) {
      print('Notification payload: ${response.payload}');
    } else {
      print("Notification Done");
    }
    // Get.to(() => Center(
    //       child: Text('Hello World'),
    //     )); // Navigate to a specific page if needed
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> displayNotification(
      {required String title, required String body}) async {
    // Android notification details
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId', // Channel ID
      'channelName', // Channel name
      importance: Importance.max,
      priority: Priority.high,
      showWhen:
          true, // Optional: Set to true if you want to show the time of the notification
    );

    // iOS notification details
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    // Combine platform-specific notification details
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Show the notification
    try {
      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        title,
        body,
        platformChannelSpecifics,
        payload: 'It could be anything you pass', // Optional payload
      );
    } catch (e) {
      print("Error displaying notification: $e");
    }
  }

  Future<void> scheduledNotification(
      int hour, int minute, TaskModel task) async {
    try {
      // Convert the hour and minute into a TZDateTime object
      tz.TZDateTime scheduledTime = convertTime(hour, minute);

      // Android notification details
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'task_channel', // Channel ID
          'Task Notifications', // Channel name
          channelDescription: 'Channel for scheduled task notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          showWhen: true);

      // iOS notification details
      var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

      // Combine platform-specific details
      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      // Schedule the notification
      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id ?? 0,
        "${task.startTime!.split(' ')[0]}-${task.startTime!}", // Notification title
        task.note, // Notification body
        scheduledTime, // Time to schedule the notification

        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exact,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time, // Match time only
        payload: task.toJson().toString(), // Optional payload
      );

      print("Notification scheduled for $scheduledTime");
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }

  tz.TZDateTime convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
