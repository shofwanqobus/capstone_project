import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:mainpage/data/models/hotel_model.dart';

class FavDatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavDatabaseProvider({required this.databaseHelper}) {
    _getFavoritedHotel();
  }

  ResultState _resultState = ResultState.loading;
  ResultState get state => _resultState;

  String _message = '';
  String get message => _message;

  List<HotelItemsModel> _favorited = [];
  List<HotelItemsModel> get favorited => _favorited;

  void _getFavoritedHotel() async {
    try {
      _favorited = await databaseHelper.getFavoritedHotel();
      if (_favorited.isNotEmpty) {
        _resultState = ResultState.hasData;
      } else {
        _resultState = ResultState.noData;
        _message = 'Favorite Hotel is Empty';
      }
      notifyListeners();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'Error';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favHotel = await databaseHelper.getFavHotelById(id);
    if (favHotel == null) {
      return false;
    }
    return favHotel.isNotEmpty;
  }

  void addFavoritedHotel(HotelItemsModel hotel) async {
    try {
      await databaseHelper.addHotel(hotel);
      _getFavoritedHotel();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'add Favorited error';
      notifyListeners();
    }
  }

  void removeFavoriteHotel(String id) async {
    try {
      await databaseHelper.removeHotel(id);
      _getFavoritedHotel();
    } catch (e) {
      _resultState = ResultState.error;
      _message = 'remove Favorited error';
      notifyListeners();
    }
  }
}
