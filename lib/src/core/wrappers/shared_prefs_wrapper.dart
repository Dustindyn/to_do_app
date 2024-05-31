import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsWrapper {
  final SharedPreferences _sharedPreferences;

  SharedPrefsWrapper(this._sharedPreferences);

  Future<void> setStringList(String key, List<String> value) async {
    await _sharedPreferences.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }
}
