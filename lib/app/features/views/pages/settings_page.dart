import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/services/notification_services.dart';
import 'package:flutter_push_notification/app/services/theme_service.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  NotifyHelper notifyHelper = NotifyHelper();
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
        centerTitle: true,
        title: const Text('Settings'),
        actions: [
          Obx(() => IconButton(
                onPressed: () {
                  notifyHelper.displayNotification(
                      body: ThemeService().isDarkMode.value
                          ? 'Hello World'
                          : 'GoodBye World',
                      title: 'Theme Changed');
                  ThemeService().switchTheme();
                },
                icon: Icon(
                  ThemeService().isDarkMode.value
                      ? FluentSystemIcons.ic_fluent_weather_moon_filled
                      : FluentSystemIcons.ic_fluent_weather_sunny_filled,
                ),
              )),
        ],
      ),
    );
  }
}
