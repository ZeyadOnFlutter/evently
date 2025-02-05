import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';
  bool get isDark => themeMode == ThemeMode.dark;

  Future<void> loadString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString('lang') ?? 'en';
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeMode =
        (prefs.getBool('isDark') ?? false) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode theme) async {
    themeMode = theme;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', themeMode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> changeLanguage(String lang) async {
    languageCode = lang;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', languageCode);
    notifyListeners();
  }
}
