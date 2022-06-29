import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mainpage/data/models/plane_ticket_model.dart';

class TicketDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  TicketDatabaseProvider({required this.databaseHelper}) {
    _getBookedTicket();
  }

  ResultState _resultState = ResultState.loading;
  ResultState get state => _resultState;

  String _message = '';
  String get message => _message;

  List<PlaneTicketItems> _booked = [];
  List<PlaneTicketItems> get booked => _booked;

  void _getBookedTicket() async {
    try {
      _booked = await databaseHelper.getBookedTicket();
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
    final bookedTicket = await databaseHelper.getTicketById(id);
    if (bookedTicket == null) {
      return false;
    }
    return bookedTicket.isNotEmpty;
  }

  void bookedTicket(PlaneTicketItems ticket) async {
    try {
      await databaseHelper.bookedTicket(ticket);

      final _auth = FirebaseAuth.instance;
      final _db = FirebaseFirestore.instance;
      final email = _auth.currentUser!.email;
      final docRef = _db.collection("users").doc(email);

      List<PlaneTicketItems> result = await databaseHelper.getBookedTicket();

      docRef.get().then(
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;

          data["booked"]["tickets"] = json.encode(result);

          await docRef.update(data);
        },
      );

      _getBookedTicket();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error while booked ticket';
      notifyListeners();
    }
  }
}
