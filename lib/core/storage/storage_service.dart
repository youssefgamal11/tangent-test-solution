import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _sharedPreferences;
  init() async {
    _sharedPreferences= await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    await _sharedPreferences?.setBool(key, value);
  }

  static bool? getBool(String key) => _sharedPreferences?.getBool(key);

  static Future<void> setString(String key, String value) async {
    
    await _sharedPreferences?.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    
    return _sharedPreferences?.getString(key);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    
    await _sharedPreferences?.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    return _sharedPreferences?.getStringList(key);
  }

  static Future<void> saveUserName(String name) =>
      setString('user_name', name);

  static Future<void> saveSelectedTopics(List<String> topics) =>
      setStringList('selected_topics', topics);

  static Future<void> saveOnboardingCompleted() =>
      setBool('onboarding_completed', true);

  static bool get isOnboardingCompleted =>
      getBool('onboarding_completed') == true;
}
