import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mainpage/data/models/trip_model.dart';

class TripDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  TripDatabaseProvider({required this.databaseHelper}) {
    _getBookedTrip();
  }

  ResultState _resultState = ResultState.loading;
  ResultState get state => _resultState;

  String _message = '';
  String get message => _message;

  List<TripItemsModel> _booked = [];
  List<TripItemsModel> get booked => _booked;

  void _getBookedTrip() async {
    try {
      _booked = await databaseHelper.getBookedTrip();
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

  Future<bool> isBooked(int id) async {
    final bookedTrip = await databaseHelper.getTripById(id);
    if (bookedTrip == null) {
      return false;
    }
    return bookedTrip.isNotEmpty;
  }

  void bookedTrip(TripItemsModel trip) async {
    try {
      await databaseHelper.bookedTrip(trip);

      final _auth = FirebaseAuth.instance;
      final _db = FirebaseFirestore.instance;
      final email = _auth.currentUser!.email;
      final docRef = _db.collection("users").doc(email);

      List<TripItemsModel> result = await databaseHelper.getBookedTrip();

      docRef.get().then(
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;

          data["booked"]["trips"] = json.encode(result);

          await docRef.update(data);
        },
      );

      _getBookedTrip();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error while booked trip';
      notifyListeners();
    }
  }
}
