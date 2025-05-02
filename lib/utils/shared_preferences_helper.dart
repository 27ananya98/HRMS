import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  /// Retrieves and prints all key-value pairs in SharedPreferences
  Future<void> printAllSharedPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Map<String, Object?> allEntries = prefs.getKeys().fold({}, (map, key) {
        map[key] = prefs.get(key);
        return map;
      });

      if (allEntries.isEmpty) {
        print('SharedPreferences: No values found.');
      } else {
        allEntries.forEach((key, value) {
          print('SharedPreferences - Key: $key, Value: $value');
        });
      }
    } catch (e) {
      print('Error accessing SharedPreferences: $e');
    }
  }
}
