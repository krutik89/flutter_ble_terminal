import 'package:ble_serial_terminal/models/schema.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  late Database _database;
  DatabaseHelper._internal();

  // Future<Database?> get database async {
  //   print("future database");
  //   try {
  //     if (_database != null) return _database;

  //     _database = await initDatabase();
  //     return _database;
  //   } catch (e) {
  //     print('Error initializing database: $e');
  //     return null;
  //   }
  // }

  Future<Database> initDatabase() async {
    print("hello moto");
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'my_app_database.db');
    print({"path", path});

    return openDatabase(path, version: 1, onCreate: _onCreateDatabase);
  }

  Future<void> _onCreateDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS Bluetoothschema(id INTEGER PRIMARY KEY AUTOINCREMENT, remoteId TEXT NOT NULL, messages TEXT NOT NULL)",
    );
  }

  Future<void> closeDatabase() async {
    final db = _database;
    print(db);
    // db?.close();
  }

  Future<void> insertData(BluetoothSchema schema) async {
    print({"schema", schema.toMap()});
    await _database.insert("Bluetoothschema", schema.toMap());
    getAllTasks();
  }

  Future<void> getAllTasks() async {
    // initDatabase();
    final data = await _database.query('Bluetoothschema');
    print({data});

    // final db = await _database!.database;
    // final List<Map<String, dynamic>> maps = await db.query('Bluetoothschema');
    // return List.generate(maps.length, (i) {
    //   return BluetoothSchema(
    //     remoteId: maps[i]['id'],
    //     messages: maps[i]['title'],
    //     // description: maps[i]['description'],
    //   );
    // });
  }

  Future<List<Map<String, dynamic>>> _getEntries1() async {
    return await _database.query('Notes');
  }
}
