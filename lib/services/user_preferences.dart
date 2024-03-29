import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUsername = 'username';
  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyCategories = 'categories';

  /// initialize preferences
  static Future<void> init() async => _preferences = await SharedPreferences.getInstance();

  static Future<bool> setUsername(String username) async => await _preferences.setString(_keyUsername, username);
  static String? getUsername() => _preferences.getString(_keyUsername);

  static Future<bool> setIsLoggedIn(bool isLoggedIn) async => await _preferences.setBool(_keyIsLoggedIn, isLoggedIn);
  static bool? getIsLoggedIn() => _preferences.getBool(_keyIsLoggedIn);

  static Future<bool> setCategories(List<String> categories) async => await _preferences.setStringList(_keyCategories, categories);
  static List<String>? getCategories() => _preferences.getStringList(_keyCategories);

}
