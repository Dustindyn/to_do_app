import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsWrapper {
  final SharedPreferences _sharedPreferences;

  SharedPrefsWrapper(this._sharedPreferences);

  Future<bool> setStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  Future<bool> setInt(String key, int n) {
    return _sharedPreferences.setInt(key, n);
  }

  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }
}
