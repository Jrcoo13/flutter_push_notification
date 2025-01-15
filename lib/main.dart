import 'package:flutter/material.dart';
import 'package:flutter_push_notification/app.dart';
import 'package:flutter_push_notification/app/config/Database.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize GetStorage
  await MyDatabase.initializeDatabase(); //Initialize database
  runApp(const App());
}
