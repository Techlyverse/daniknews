import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  static const _keyIsLoggedIn = 'isLoggedIn';
  static const _keyCategories = 'categories';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async => await _preferences!.setString(_keyUsername, username);
  static String? getUsername() => _preferences!.getString(_keyUsername);

  static Future setIsLoggedIn(bool isLoggedIn) async => await _preferences!.setBool(_keyIsLoggedIn, isLoggedIn);
  static bool? getIsLoggedIn() => _preferences!.getBool(_keyIsLoggedIn);

  static Future setCategories(List<String> categories) async => await _preferences!.setStringList(_keyCategories, categories);
  static List<String>? getCategories() => _preferences!.getStringList(_keyCategories);

}
