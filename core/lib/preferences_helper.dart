import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyHotel = 'SCHEDULING_HOTEL';

  Future<bool> get isDailyHotelActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyHotel) ?? false;
  }

  void setDailyHotel(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyHotel, value);
  }
}
