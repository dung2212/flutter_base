import 'package:shared_preferences/shared_preferences.dart';

class PreferUtil {
  static Future<bool> checkKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //Int

  static Future createInt(String key, int intValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setInt(key, intValue);
    }
  }

  static Future setInt(String key, int intValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, intValue);
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key) ?? 0;
    return value;
  }

  //Double
  static Future createDouble(String key, double doubleValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setDouble(key, doubleValue);
    }
  }

  static Future setDouble(String key, double doubleValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, doubleValue);
  }

  static Future<double> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getDouble(key) ?? 0;
    return value;
  }

  //Double
  static Future createBool(String key, bool boolValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setBool(key, boolValue);
    }
  }

  static Future setBool(String key, bool boolValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, boolValue);
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key) ?? false;
    return value;
  }

  //String
  static Future createString(String key, String stringValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setString(key, stringValue);
    }
  }

  static Future setString(String key, String stringValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, stringValue);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? "";
    return value;
  }

  //List String
  static Future createListString(
      String key, List<String> listStringValue) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      prefs.setStringList(key, listStringValue);
    }
  }

  static Future setListString(String key, List<String> listStringValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, listStringValue);
  }

  static Future<List<String>> getListString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList(key) ?? List<String>();
    return value;
  }
}
