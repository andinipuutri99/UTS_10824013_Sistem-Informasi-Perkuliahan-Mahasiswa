import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('kampusin.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        nim TEXT UNIQUE,
        username TEXT,
        email TEXT,
        className TEXT,
        studyProgram TEXT,
        faculty TEXT,
        yearOfEntry TEXT,
        password TEXT,
        points INTEGER,
        level TEXT
      )
    ''');
  }

  Future<int> createUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String nim, String password) async {
    final db = await instance.database;

    final result = await db.query(
      'users',
      where: 'nim = ? AND password = ?',
      whereArgs: [nim, password],
    );

    if (result.isNotEmpty) return result.first;
    return null;
  }
}