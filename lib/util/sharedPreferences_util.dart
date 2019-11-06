import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String SHARE_PREF_USERNAME = 'userName';
  static const String SHARE_PREF_COOKIE = 'cookie';
  static const String SHARE_THEME_COLOR = 'theme_color';

  static put(String key, dynamic value) async {
    var sharePrefs = await SharedPreferences.getInstance();
    if (value is String) {
      sharePrefs.setString(key, value);
    } else if (value is int) {
      sharePrefs.setInt(key, value);
    } else if (value is double) {
      sharePrefs.setDouble(key, value);
    } else if (value is bool) {
      sharePrefs.setBool(key, value);
    } else if (value is List) {
      sharePrefs.setStringList(key, value);
    }
  }

  static get(String key) async {
    var sharePrefs = await SharedPreferences.getInstance();
    return sharePrefs.get(key);
  }

  static getString(String key, {String defValue = ''}) async {
    var sharePrefs = await SharedPreferences.getInstance();
    return sharePrefs.getString(key) ?? defValue;
  }
}
