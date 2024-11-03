import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();
  factory DatabaseService() => instance;
  DatabaseService._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "notes.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  static Future<void> deleteDatabase() async {
    print("ddrfwscv");
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "notes.db");
    try {
      databaseFactory.deleteDatabase(path);
      debugPrint('Deleted');
    } catch (e) {
      debugPrint('Error deleting database: $e');
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
  Future<void> _createDatabase(Database db, int version) async {
    debugPrint("HERE MY LORD");
    await db.execute('''
        CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          created_time TEXT NOT NULL

        )
      ''');
  }
}
