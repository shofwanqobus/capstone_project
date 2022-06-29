import 'dart:async';
import 'dart:convert';

import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/data/models/plane_ticket_model.dart';
import 'package:mainpage/data/models/trip_model.dart';
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
    await db.execute('''
      CREATE TABLE  $_tblHotel (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        description TEXT,
        address TEXT,
        price INTEGER,
        rating DOUBLE
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblTrip (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        description TEXT,
        location TEXT,
        price INTEGER,
        rating DOUBLE
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblTicket (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        routes TEXT,
        location TEXT,
        price INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_favHotels (
        id TEXT PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        description TEXT,
        address TEXT,
        price INTEGER,
        rating DOUBLE
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_favTrips (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photoUrl TEXT,
        description TEXT,
        location TEXT,
        price INTEGER,
        rating DOUBLE
      );
    ''');
  }

  Future<void> bookedHotel(HotelItemsModel hotel) async {
    final db = await database;
    await db!.insert(_tblHotel, hotel.toJson());
  }

  Future<List<HotelItemsModel>> getBookedHotel() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblHotel);

    return result.map((data) => HotelItemsModel.fromJson(data)).toList();
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

  Future<void> bookedTrip(TripItemsModel trip) async {
    final db = await database;
    await db!.insert(_tblTrip, trip.toJson());
  }

  Future<List<TripItemsModel>> getBookedTrip() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblTrip);

    return result.map((data) => TripItemsModel.fromJson(data)).toList();
  }

  Future<Map<String, dynamic>?> getTripById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTrip,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<void> bookedTicket(PlaneTicketItems ticket) async {
    final db = await database;
    await db!.insert(_tblTicket, ticket.toJson());
  }

  Future<List<PlaneTicketItems>> getBookedTicket() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblTicket);

    return result.map((data) => PlaneTicketItems.fromJson(data)).toList();
  }

  Future<Map<String, dynamic>?> getTicketById(String id) async {
    final db = await database;
    final results = await db!.query(
      _tblTicket,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<TripItemsModel>> getFavoriteTrip() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_favTrips);

    return result.map((data) => TripItemsModel.fromJson(data)).toList();
  }

  Future<List<HotelItemsModel>> getFavoriteHotels() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_favHotels);

    return result.map((data) => HotelItemsModel.fromJson(data)).toList();
  }

  Future<bool> getFavoriteTripById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      _favTrips,
      where: 'id = ?',
      whereArgs: [id],
    );

    final mappedResult =
        result.map((data) => TripItemsModel.fromJson(data)).toList();

    if (mappedResult.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> getFavoriteHotelById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      _favHotels,
      where: 'id = ?',
      whereArgs: [id],
    );

    final mappedResult =
        result.map((data) => HotelItemsModel.fromJson(data)).toList();

    if (mappedResult.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addFavoriteTrip(TripItemsModel trip) async {
    final db = await database;
    await db!.insert(_favTrips, trip.toJson());
  }

  Future<void> addFavoriteHotel(HotelItemsModel hotel) async {
    final db = await database;
    await db!.insert(_favHotels, hotel.toJson());
  }

  Future<void> removeFavoriteTripById(int id) async {
    final db = await database;
    await db!.delete(_favTrips, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> removeFavoriteHotelById(String id) async {
    final db = await database;
    await db!.delete(_favHotels, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> setFavoriteTrips(String trips) async {
    final db = await database;

    final data = json.decode(trips);

    for (Map<String, dynamic> trip in data) {
      await db!.insert(_favTrips, trip);
    }
  }

  Future<void> setFavoriteHotels(String hotels) async {
    final db = await database;

    final data = json.decode(hotels);

    for (Map<String, dynamic> hotel in data) {
      await db!.insert(_favHotels, hotel);
    }
  }

  Future<void> setBookedHotels(String hotels) async {
    final db = await database;

    final data = json.decode(hotels);

    for (Map<String, dynamic> hotel in data) {
      await db!.insert(_tblHotel, hotel);
    }
  }

  Future<void> setBookedTrips(String trips) async {
    final db = await database;

    final data = json.decode(trips);

    for (Map<String, dynamic> trip in data) {
      await db!.insert(_tblTrip, trip);
    }
  }

  Future<void> setBookedTickets(String tickets) async {
    final db = await database;

    final data = json.decode(tickets);

    for (Map<String, dynamic> ticket in data) {
      await db!.insert(_tblTicket, ticket);
    }
  }

  Future<void> clearcache() async {
    final db = await database;

    await db!.delete(_favTrips);
    await db.delete(_favHotels);

    await db.delete(_tblHotel);
    await db.delete(_tblTrip);
    await db.delete(_tblTicket);
  }
}
