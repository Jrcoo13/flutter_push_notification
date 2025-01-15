// ignore_for_file: file_names

import 'package:flutter_push_notification/app/config/Database.dart';
import 'package:flutter_push_notification/app/features/models/taskModel.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getTasks();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? task}) async {
    return await MyDatabase.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await MyDatabase.query();
    taskList.assignAll(tasks.map((data) => TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel task) async {
    await MyDatabase.delete(task);
  }

  void taskCompleted(int id) async {
    await MyDatabase.update(id);
  }
}
