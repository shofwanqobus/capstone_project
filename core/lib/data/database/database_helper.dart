import 'dart:async';

import 'package:mainpage/data/models/hotel_model.dart';
import 'package:sqflite/sqflite.dart';

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

  static const String _tblHotel = 'hotels';
  static const String _tblTrip = 'trips';
  static const String _tblTicket = 'tickets';

  static const String _favHotels = 'fav_hotel';
  static const String _favTrips = 'fav_trip';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/be_traveled.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE  $_tblHotel (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        price INTEGER
      );
    ''');

    await db.execute(
        '''
      CREATE TABLE  $_tblTrip (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        price INTEGER
      );
    ''');

    await db.execute(
        '''
      CREATE TABLE  $_tblTicket (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        price INTEGER
      );
    ''');

    await db.execute(
        '''
      CREATE TABLE  $_favHotels (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        price INTEGER
      );
    ''');

    await db.execute(
        '''
      CREATE TABLE  $_favTrips (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        price INTEGER
      );
    ''');
  }

  Future<void> bookedHotel(HotelItemsModel hotel) async {
    final db = await database;
    await db!.insert(_tblHotel, hotel.toJson());
  }

  Future<Map<String, dynamic>?> getHotelById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblHotel,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<HotelItemsModel>> getBookedHotel() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblHotel);

    return result.map((data) => HotelItemsModel.fromJson(data)).toList();
  }

  Future<void> addHotel(HotelItemsModel hotel) async {
    final db = await database;
    await db!.insert(_favHotels, hotel.toJson());
  }

  Future<List<HotelItemsModel>> getFavoritedHotel() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_favHotels);

    return result.map((data) => HotelItemsModel.fromJson(data)).toList();
  }

  Future<Map<String, dynamic>?> getFavHotelById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblHotel,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<void> removeHotel(String id) async {
    final db = await database;
    await db!.delete(_favHotels, where: 'id = ?', whereArgs: [id]);
  }
}
