import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app/features/resources/app_theme.dart';
import 'package:flutter_push_notification/app/features/views/layout/main_page.dart';
import 'package:flutter_push_notification/app/services/theme_service.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          darkTheme: AppThemes.dark,
          theme: AppThemes.light,
          themeMode: ThemeService().theme, // Use reactive theme
          home: const MainPage(),
        ));
  }
}
