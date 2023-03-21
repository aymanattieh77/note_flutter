import 'package:shared_preferences/shared_preferences.dart';

class ThemeCache {
  static const darkMode = 'darkm';

  Future<bool?>? getTheme() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(darkMode);
  }

  setTheme(bool isDark) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(darkMode, isDark);
  }
}
