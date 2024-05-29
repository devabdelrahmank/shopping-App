import 'package:shared_preferences/shared_preferences.dart';

class cache_helper {
  static late SharedPreferences preferences;

  init() async {
    preferences = await SharedPreferences.getInstance();
  }

  String? getDataString({
    required String key,
  }) {
    return preferences.getString(key);
  }

  Future<bool> SaveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) {
      return await preferences.setBool(key, value);
    }
    if (value is String) {
      return await preferences.setString(key, value);
    }
    if (value is int) {
      return await preferences.setInt(key, value);
    } else {
      return await preferences.setDouble(key, value);
    }
  }

  dynamic getData({required String key}) {
    return preferences.get(key);
  }

  Future<bool> RemoveData({required String key}) {
    return preferences.remove(key);
  }
}
