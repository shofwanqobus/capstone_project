import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mainpage/data/models/hotel_model.dart';
import 'package:mainpage/data/models/trip_model.dart';

class FavoriteDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteDatabaseProvider({required this.databaseHelper}) {
    getFavoriteHotels();
    getFavoriteTrips();
  }

  ResultState _tripState = ResultState.loading;
  ResultState get tripState => _tripState;

  ResultState _hotelState = ResultState.loading;
  ResultState get hotelState => _hotelState;

  String _message = '';
  String get message => _message;

  List<HotelItemsModel> _favoriteHotels = [];
  List<HotelItemsModel> get favoriteHotels => _favoriteHotels;

  List<TripItemsModel> _favoriteTrips = [];
  List<TripItemsModel> get favoriteTrips => _favoriteTrips;

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void getFavoriteTrips() async {
    final result = await databaseHelper.getFavoriteTrip();

    if (result.isNotEmpty) {
      _favoriteTrips = result;
      _tripState = ResultState.hasData;
    } else {
      _tripState = ResultState.noData;
      _message = "no trip favorited yet";
    }
    notifyListeners();
  }

  void getFavoriteHotels() async {
    try {
      final result = await databaseHelper.getFavoriteHotels();

      if (result.isNotEmpty) {
        _favoriteHotels = result;
        _hotelState = ResultState.hasData;
      } else {
        _hotelState = ResultState.noData;
        _message = "no hotel favorited yet";
      }
      notifyListeners();
    } catch (e) {
      _hotelState = ResultState.error;
      _message = 'Error';
      notifyListeners();
    }
  }

  Future<void> setFavoriteTrip(TripItemsModel trip) async {
    final isExists = await databaseHelper.getFavoriteTripById(trip.id);

    if (isExists) {
      await databaseHelper.removeFavoriteTripById(trip.id);
    } else {
      await databaseHelper.addFavoriteTrip(trip);
    }

    final email = _auth.currentUser!.email;

    final docRef = _db.collection("users").doc(email);

    List<TripItemsModel> result = await databaseHelper.getFavoriteTrip();

    docRef.get().then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        data["favorites"]["trips"] = json.encode(result);

        await docRef.update(data);
      },
    );

    isTripFavoritedById(trip.id);
  }

  Future<void> setFavoriteHotel(HotelItemsModel hotel) async {
    final isExists = await databaseHelper.getFavoriteHotelById(hotel.id);

    if (isExists) {
      await databaseHelper.removeFavoriteHotelById(hotel.id);
    } else {
      await databaseHelper.addFavoriteHotel(hotel);
    }

    final email = _auth.currentUser!.email;

    final docRef = _db.collection("users").doc(email);

    List<HotelItemsModel> result = await databaseHelper.getFavoriteHotels();

    docRef.get().then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;

        data["favorites"]["hotels"] = json.encode(result);

        await docRef.update(data);
      },
    );

    isHotelFavoritedById(hotel.id);
  }

  bool _isTripFavorited = false;
  bool get isTripFavorited => _isTripFavorited;

  Future<bool> isTripFavoritedById(int id) async {
    final isExists = await databaseHelper.getFavoriteTripById(id);

    if (isExists) {
      _isTripFavorited = true;
      notifyListeners();
      return true;
    } else {
      _isTripFavorited = false;
      notifyListeners();
      return false;
    }
  }

  bool _isHotelFavorited = false;
  bool get isHotelFavorited => _isHotelFavorited;

  Future<bool> isHotelFavoritedById(String id) async {
    final isExists = await databaseHelper.getFavoriteHotelById(id);

    if (isExists) {
      _isHotelFavorited = true;
      notifyListeners();
      return true;
    } else {
      _isHotelFavorited = false;
      notifyListeners();
      return false;
    }
  }
}
