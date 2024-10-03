import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // variables
  static const dbName = "myDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
  static const columnId = "id";
  static const String columnImagePath="pic";
  static const columnName = "name";
  static const columnEmail = "email"; // status
  static const columnContact = "contact"; //date added

  // constructor
  static final DatabaseHelper instance = DatabaseHelper();

  // databases initialize
  static Database? _database;

  // Constructor with print statement
  DatabaseHelper() {
    print("DatabaseHelper constructor");
  }

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    print("Initializing database");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    print("Database path: $path");
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }
//id,name, img, status, date, 
  Future<void> onCreate(Database db, int version) async {
    print("Creating the database table");
    await db.execute('''
      CREATE TABLE $dbTable(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL,
      $columnImagePath TEXT NOT NULL,
      $columnContact TEXT NOT NULL
      )
      ''');

  }

  // insert method
  Future<int?> insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    print('add successfully');
    return await db?.insert(dbTable, row);
  }


  // read method
  Future<List<Map<String, dynamic>>?> queryDatabase() async {
    Database? db = await instance.database;
    return await db?.query(dbTable);
  }

  // update method
  Future<int?> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db?.update(dbTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete
  Future<int?> deleteRecord(int id) async {
    Database? db = await instance.database;
    await db?.delete(dbTable, where: "id = ?", whereArgs: [id]);
    return null;

  }
}