import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/tasks_model.dart';

class DatabaseHelper {
  static final _dbName = 'todoDB';
  static final _dbVersion = 1;
  static final _dbTable1 = 'tasks';

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, _dbName);
    return openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    String script = '''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT, 
        description TEXT, 
        deadline TEXT,
        status INTEGER
      )
    ''';
    await db.execute(script);
  }

  //CRUD
  Future<int> insert(Map<String, dynamic> row) async {
    var connection = await database;
    return await connection!.insert(_dbTable1, row);
  }

  Future<List<TaskModel>> getTaskList({required bool completed}) async {
    var connection = await database;
    var taskList =
        await connection!.query(_dbTable1, where: 'status = ?', whereArgs: [completed?1:0]);
    return taskList.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<TaskModel> getTask(int id) async {
    var connection = await database;
    var task =
        await connection!.query(_dbTable1, where: 'id = ?', whereArgs: [id]);
    return TaskModel.fromMap(task.first);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var connection = await database;
    return await connection!
        .update(_dbTable1, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> changeState({required int taskId, required bool completed}) async {
    var connection = await database;
    return await connection!.rawUpdate('''
      UPDATE $_dbTable1 
        SET status = ?
        WHERE id = ?
      ''',
      [completed ? 1 : 0, taskId]
    );
  }

  Future<int> delete(int id) async {
    var connection = await database;
    return await connection!.delete(_dbTable1, where: 'id = ?', whereArgs: [id]);
  }
}
