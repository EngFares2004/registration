import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  SharedHandler._privateConstructor();

  static final SharedHandler instance = SharedHandler._privateConstructor();
  SharedPreferences? _prefs ;

  Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      await _prefs?.setString(key, value);
    } else if (value is int) {
      await _prefs?.setInt(key, value);
    } else if (value is bool) {
      await _prefs?.setBool(key, value);
    } else if (value is double) {
      await _prefs?.setDouble(key, value);
    }  }

  Future<dynamic> readData(String key) async {
    return _prefs?.get(key);

  }

  Future<void> init() async {
     _prefs = await SharedPreferences.getInstance();
    print("SharedHandler initialized");
  }
  Future<void> clearAllData() async {
    await _prefs?.clear();
  }
}
