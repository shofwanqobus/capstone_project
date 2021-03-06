import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mainpage/data/models/hotel_model.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getBookedHotel();
  }

  ResultState _resultState = ResultState.loading;
  ResultState get state => _resultState;

  String _message = '';
  String get message => _message;

  List<HotelItemsModel> _booked = [];
  List<HotelItemsModel> get booked => _booked;

  void _getBookedHotel() async {
    try {
      _booked = await databaseHelper.getBookedHotel();
      if (_booked.isNotEmpty) {
        _resultState = ResultState.hasData;
      } else {
        _resultState = ResultState.noData;
        _message = 'You still not Booked yet';
      }
      notifyListeners();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error';
      notifyListeners();
    }
  }

  Future<bool> isBooked(String id) async {
    final bookedHotel = await databaseHelper.getHotelById(id);
    if (bookedHotel == null) {
      return false;
    }
    return bookedHotel.isNotEmpty;
  }

  void bookedHotel(HotelItemsModel hotel) async {
    try {
      await databaseHelper.bookedHotel(hotel);

      final _auth = FirebaseAuth.instance;
      final _db = FirebaseFirestore.instance;
      final email = _auth.currentUser!.email;
      final docRef = _db.collection("users").doc(email);

      List<HotelItemsModel> result = await databaseHelper.getBookedHotel();

      docRef.get().then(
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;

          data["booked"]["hotels"] = json.encode(result);

          await docRef.update(data);
        },
      );

      _getBookedHotel();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error while booked hotel';
      notifyListeners();
    }
  }
}
