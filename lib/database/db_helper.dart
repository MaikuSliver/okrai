// ignore_for_file: depend_on_referenced_packages
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
    //("DatabaseHelper constructor");
  }

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future<Database?> initDB() async {
    //print("Initializing database");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    //print("Database path: $path");
    _database = await openDatabase(path, version: dbVersion, onCreate: onCreate);
    return _database;
  }

  // Create tables for `myTable` and `progress`
  Future<void> onCreate(Database db, int version) async {
    //print("Creating the database table");

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
    //print('Record added successfully to myTable');
    return await db?.insert(dbTable, row);
  }

// Query method for `myTable`
Future<List<Map<String, dynamic>>?> queryDatabase() async {
  Database? db = await instance.database;
  // Add orderBy to sort by id in descending order
  return await db?.query(
    dbTable,
    orderBy: '$columnId DESC', // Sort by id in descending order
  );
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
    //print('Progress added successfully');
    return await db?.insert(progressTable, row);
  }

    // Query method for `progress` table (to get progress for a specific plant)
    Future<List<Map<String, dynamic>>?> queryProgress(int plantId) async {
    Database? db = await instance.database;
    return await db?.query(progressTable,
                           where: '${DatabaseHelper.plantId} = ?',  // Use column name for plantId
                           whereArgs: [plantId],  // plantId is passed as an argument
                           orderBy: '${DatabaseHelper.progressId} DESC',
  ); // plantId is passed as an argument);
  }
   // Query function to get all progress entries (progressImages, progressDate) for a specific plant (plantId)
  Future<List<Map<String, dynamic>>?> queryProgressByPlantId(int plantId) async {
    Database? db = await instance.database;
    // Query to get all progress entries for the specific plantId
    return await db?.query(
      progressTable,
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

    // Function to delete all rows with a given plantid
  Future<int?> deleteProgress(int id) async {
    final db = await database;
    //print('succesfully  plant id');
    // Delete rows where plantid matches the id
    return await db?.delete(
      progressTable,
      where: 'plantid = ?',
      whereArgs: [id],
    ); 
   
  }

  //total scans

Future<int> countTotalRows() async {
    final db = await database; // Get the database instance
    final result = await db!.rawQuery('SELECT COUNT($columnId) FROM $dbTable'); 
  //  print('total $result'); // Debugging line to check the result
    return Sqflite.firstIntValue(result)!; // Extract the count value
}


// Method to count total healthy records
  Future<int> countTotalHealthy() async {
    final db = await database;
    final result = await db!.rawQuery('SELECT COUNT(*) FROM $dbTable WHERE $columnEmail = "Healthy"');
    return Sqflite.firstIntValue(result)!; // Extract the count value
  }

  // Method to count total disease records (i.e., records where columnEmail is NOT "Healthy")
  Future<int> countTotalDisease() async {
    final db = await database;
    final result = await db!.rawQuery('SELECT COUNT(*) FROM $dbTable WHERE $columnEmail != "Healthy"');
    return Sqflite.firstIntValue(result)!; // Extract the count value
  }

///////////REPORTS QUERY/////////////////////////////////////////////////////////////////////////////////////

// Method to count total healthy records

  // Method to count daily scans records by current date which is october right now
  //by count the progress table id group by each date today within current month for 30 days
  
Future<Map<String, int>> countDiseasesByType() async {
  // Access the database
  final db = await instance.database;

  // Fetch disease counts excluding "Healthy"
  final List<Map<String, dynamic>> results = await db!.rawQuery(
    'SELECT email, COUNT(*) as count FROM myTable WHERE email IS NOT NULL AND email != "Healthy" GROUP BY email'
  );

  // Create a mapping for specific email values to their broader categories
  const emailMap = {
    'Mild Early Blight Disease': 'Early Blight',
    'Severe Early Blight Disease': 'Early Blight',
    'Critical Early Blight Disease': 'Early Blight',
    'Mild Yellow Vein Mosaic Disease': 'Yellow Vein',
    'Severe Yellow Vein Mosaic Disease': 'Yellow Vein',
    'Critical Yellow Vein Mosaic Disease': 'Yellow Vein',
    'Mild Leaf Curl Disease': 'Leaf Curl',
    'Severe Leaf Curl Disease': 'Leaf Curl',
    'Critical Leaf Curl Disease': 'Leaf Curl',
  };

  // Convert results to a map with grouped email counts
  final Map<String, int> groupedEmailCounts = {};
  
  for (var e in results) {
    // Get the current email
    final email = e['email'] as String;
    
    // Find the corresponding broader category
    final category = emailMap[email] ?? email; // Default to original if not found

    // Increment the count for the corresponding category
    groupedEmailCounts[category] = (groupedEmailCounts[category] ?? 0) + (e['count'] as int);
  }

  return groupedEmailCounts;
}

Future<Map<String, int>> countPesticidesUsed() async {
  // Access the database
  final db = await instance.database;

  // Fetch pesticide counts grouped by listpest, excluding unwanted values,
  // ordered by count in descending order, limited to 5
  final List<Map<String, dynamic>> results = await db!.rawQuery(
    '''SELECT listpest, COUNT(*) as count 
       FROM $progressTable 
       WHERE listpest NOT IN ('na', 'none', 'n/a', '') 
       GROUP BY listpest 
       ORDER BY count DESC 
       LIMIT 5'''
  );

  // Convert results to a map
  return { for (var e in results) e['listpest'] as String: e['count'] as int };
}

 // New Method to count progressId grouped by progressDate for the current month
  Future<Map<String, int>> countProgressByDate() async {
    // Access the database
    final db = await instance.database;

    // Get the current month and year

    // Fetch counts of progressId grouped by progressDate within the current month
    final List<Map<String, dynamic>> results = await db!.rawQuery(
      '''
      SELECT date, COUNT(progressId) as count 
      FROM $progressTable 
      GROUP BY date
      ''',
    );

    // Convert results to a map
    return { for (var e in results) e['date'] as String: e['count'] as int };
  }
  
}
