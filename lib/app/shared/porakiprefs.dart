import 'package:shared_preferences/shared_preferences.dart';

class PorAkiPrefs {

  static void savePrefStr(String key, String message) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  Future<String?> getPrefStr(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

}