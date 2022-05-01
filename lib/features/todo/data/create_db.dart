import 'package:flutter/foundation.dart';
import 'package:reference_project_flutter/features/todo/data/model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "task";
  
  static Future<void> initDb () async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "task.db";
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db,version) {
          print('created a new one');
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING,note TEXT,date STRING, "
                "startTime STRING, endTime STRING, "
                "remind INTEGER, repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)"
          );
        },
      );
    }catch(e) {
      if (kDebugMode) {
        print (e);
      }
    }
  }
  static Future<int> insert(TaskModel? task) async {
    print("insert function called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

  static Future<List<Map<String,dynamic>>> query() async {
    print("query funcation called");
    return await _db!.query(_tableName);
  }

  static Future<void> delete(TaskModel task) async {
    await _db!.delete(_tableName,where: 'id=?',whereArgs: [task.id]);
  }

  static update(int id) async
  {
    await _db!.rawUpdate('''
    UPDATE task
    SET isCompleted = ?
    WHERE id=?
    ''',[1,id]);
  }
}