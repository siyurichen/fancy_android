import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static put(String key, String value) async {
    var sharePrefs = await SharedPreferences.getInstance();
    await sharePrefs.setString(key, value);
  }

  static get(String key, Function callBack) async {
    SharedPreferences.getInstance().then((sharePrefs) {
      callBack(sharePrefs.getString(key));
    });
  }

  static putStringList(String key, List<String> value) async {
    var sharePrefs = await SharedPreferences.getInstance();
    await sharePrefs.setStringList(key, value);
  }

  static getStringList(String key, Function callBack) async {
    SharedPreferences.getInstance().then((sharePrefs) {
      callBack(sharePrefs.getStringList(key));
    });
  }

  static saveCookies(String value) {
    put('cookie', value);
  }

  static saveUserName(String value) {
    put('userName', value);
  }

  static savePassWord(String value) {
    put('passWord', value);
  }

  static saveCookiesExpire(String value) {
    put('expire', value);
  }

  static getCookies(Function callBack) {
    get('cookie', callBack);
  }

  static getUserName(Function callBack) {
    get('userName', callBack);
  }

  static getPassWord(Function callBack) {
    get('passWord', callBack);
  }

  static getCookiesExpire(Function callBack) {
    get('expire', callBack);
  }
}
