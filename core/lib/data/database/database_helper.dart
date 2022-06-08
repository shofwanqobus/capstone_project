import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:login/data/models/user_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblUsers = 'users';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/be_traveled.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblUsers (
        id TEXT PRIMARY KEY,
        username TEXT,
        password TEXT,
        email TEXT
      );
    ''');
  }

  Future<int> addUsers(UsersTable user) async {
    final db = await database;
    return await db!.insert(_tblUsers, user.toJson());
  }

  Future<int> removeUsers(UsersTable user) async {
    final db = await database;
    return await db!.delete(
      _tblUsers,
      where: 'id=?',
      whereArgs: [user.id],
    );
  }

  Future<Map<String, dynamic>?> getUsersById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblUsers,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getUsersList() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblUsers);

    return results;
  }
}
