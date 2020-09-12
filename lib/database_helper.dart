import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "todoApp.db";
  static final _databaseVersion = 1;

  static final table = 'todo';

  static final columnId='columnId';
  static final title = 'title';
  static final description = 'description';
  static final dateTime = 'dateTime';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database; // single reference to the DB
  Future<Database> get database async {
    if (_database != null) return _database;
    //instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $title TEXT NOT NULL,
            $description TEXT ,
            $dateTime INTEGER NOT NULL
           )
          ''');
  }


  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Rows are returned as a list of maps, where each map is a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('Select * from $table ORDER By $dateTime DESC');
  }


  // update the row based on the previous datetime value
  Future<int> update(Map<String, dynamic> row,int prevDatetime) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '$dateTime = ?', whereArgs: [prevDatetime]);
  }

  // Deletes the row specified by the datetimevalue
  Future<int> delete(int dateTimeValue) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$dateTime = ?', whereArgs: [dateTimeValue]);
  }
}