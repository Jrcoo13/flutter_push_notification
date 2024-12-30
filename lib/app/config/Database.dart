// ignore_for_file: file_names, avoid_print

import 'package:flutter_push_notification/app/features/models/taskModel.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static Database? myDb;
  static final String databaseName = 'tasks.db';
  static final int version = 1;
  static final String tableName = 'tasks';

  static Future<void> initializeDatabase() async {
    if (myDb != null) return;

    print('Database is initializing');
    try {
      String path = '${await getDatabasesPath()}$databaseName';
      myDb = await openDatabase(path, version: version,
          onCreate: (db, version) async {
        await db.execute("CREATE TABLE $tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING NOT NULL,"
            "note TEXT NOT NULL,"
            "date STRING NOT NULL,"
            "startTime STRING NOT NULL,"
            "endTime STRING NOT NULL,"
            "reminder STRING NOT NULL,"
            "color INTEGER NOT NULL,"
            "isCompleted INTEGER NOT NULL)");
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(TaskModel? task) async {
    return await myDb!.insert(tableName, task!.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('querying database');
    return await myDb!.query(tableName);
  }

  static delete(TaskModel task) async {
    await myDb!.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await myDb!.rawUpdate('''
        UPDATE $tableName SET isCompleted = ? WHERE id = ?
    ''', [1, id]);
  }
}
