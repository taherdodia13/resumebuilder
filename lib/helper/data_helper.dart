import 'package:path/path.dart';

import '../utils/exports.dart';

class DatabaseHelper {
  static const _databaseName = 'resume_database.db';
  static const _databaseVersion = 1;
  static const _tableResumes = 'resumes';

  // Make the DatabaseHelper a singleton
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableResumes (
        id INTEGER PRIMARY KEY,
        fullName TEXT,
        email TEXT,
        phone TEXT,
        education TEXT,
        summary TEXT
      )
    ''');
  }

  Future<void> insertResume(Resume resume) async {
    final db = await database;
    await db.insert(
      _tableResumes,
      resume
          .toMap(), // Assuming `toMap()` method in the Resume class to convert to Map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateResume(Resume updatedResume) async {
    final db = await database;
    await db.update(
      _tableResumes,
      updatedResume.toMap(),
      where: 'id = ?',
      whereArgs: [updatedResume.id],
    );
  }

   Future<void> deleteResume(String id) async {
    final db = await database;
    await db.delete(
      _tableResumes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Resume>> getResumes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableResumes);

    return List.generate(maps.length, (i) {
      return Resume(
        id: maps[i]['id'].toString(), // Assuming 'id' is retrieved as a string
        fullName: maps[i]['fullName'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        education: maps[i]['education'],
        summary: maps[i]['summary'],
      );
    });
  }
}
