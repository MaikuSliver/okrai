import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // variables for myTable
  static const dbName = "myDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
  static const columnId = "id";
  static const String columnImagePath = "pic";
  static const columnName = "name";
  static const columnEmail = "email"; // status
  static const columnContact = "contact"; // date added
  static const columnPest = "pest"; // pesticide

  // variables for progress table
  static const progressTable = "progress";
  static const progressId = "progressId";
  static const plantId = "plantid";  // Foreign key referencing myTable id
  static const progressImages = "images";  // Path to images
  static const progressDate = "date";  // Date of the progress entry
  static const progressPest = "listpest"; 

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

  // Create tables for `myTable` and `progress`
  Future<void> onCreate(Database db, int version) async {
    print("Creating the database table");

    // Create `myTable`
    await db.execute('''
      CREATE TABLE $dbTable(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL,
      $columnImagePath TEXT NOT NULL,
      $columnContact TEXT NOT NULL,
      $columnPest TEXT NOT NULL
      )
    ''');

    // Create `progress` table
    await db.execute('''
      CREATE TABLE $progressTable (
      $progressId INTEGER PRIMARY KEY AUTOINCREMENT,
      $plantId INTEGER NOT NULL,
      $progressImages TEXT NOT NULL,
      $progressDate TEXT NOT NULL,
      $progressPest TEXT NOT NULL,
      FOREIGN KEY ($plantId) REFERENCES $dbTable($columnId) ON DELETE CASCADE
      )
    ''');
  }

  // Insert method for `myTable`
  Future<int?> insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    print('Record added successfully to myTable');
    return await db?.insert(dbTable, row);
  }

  // Query method for `myTable`
  Future<List<Map<String, dynamic>>?> queryDatabase() async {
    Database? db = await instance.database;
    return await db?.query(dbTable);
  }

  // Update method for `myTable`
  Future<int?> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db?.update(dbTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete method for `myTable`
  Future<int?> deleteRecord(int id) async {
    Database? db = await instance.database;
    await db?.delete(dbTable, where: "$columnId = ?", whereArgs: [id]);
    return null;
  }

/////////////////////////////PROGRESS TABLE QUERIES///////////////////////////////////////// 
///
   
  
   // Insert method for `progress`
  Future<int?> insertProgress(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    print('Progress added successfully');
    return await db?.insert(progressTable, row);
  }

    // Query method for `progress` table (to get progress for a specific plant)
    Future<List<Map<String, dynamic>>?> queryProgress(int plantId) async {
    Database? db = await instance.database;
    return await db?.query(progressTable, where: '$plantId = ?', whereArgs: [plantId]);
  }
   // Query function to get all progress entries (progressImages, progressDate) for a specific plant (plantId)
  Future<List<Map<String, dynamic>>?> queryProgressByPlantId(int plantId) async {
    Database? db = await instance.database;
    // Query to get all progress entries for the specific plantId
    return await db?.query(
      progressTable,
      columns: [progressImages, progressDate, progressPest], // Select only the image and date columns
      where: '$DatabaseHelper.plantId = ?',   // Filter by plantId
      whereArgs: [plantId],                   // Pass the plantId as an argument
    );
  }

   // Update method for `progress` table
  Future<int?> updateProgress(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[progressId];
    return await db?.update(progressTable, row, where: '$progressId = ?', whereArgs: [id]);
  }

    // Delete method for `progress`
  Future<int?> deleteProgress(int id) async {
    Database? db = await instance.database;
    await db?.delete(progressTable, where: "$progressId = ?", whereArgs: [id]);
    return null;
  }

}
