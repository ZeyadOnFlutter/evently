import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark }

enum AppLanguage { en, ar }

class SettingsProvider with ChangeNotifier {
  AppTheme _theme = AppTheme.light;
  AppLanguage _language = AppLanguage.en;

  AppTheme get theme => _theme;
  AppLanguage get language => _language;
  bool get isDark => _theme == AppTheme.dark;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _theme = (prefs.getBool('isDark') ?? false) ? AppTheme.dark : AppTheme.light;
    final lang = prefs.getString('lang');
    _language = (lang == 'ar') ? AppLanguage.ar : AppLanguage.en;
    notifyListeners();
  }

  Future<void> changeTheme(AppTheme newTheme) async {
    _theme = newTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  Future<void> changeLanguage(AppLanguage newLanguage) async {
    _language = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', newLanguage.name);
    notifyListeners();
  }

  /// Use switch to map AppTheme to ThemeMode
  ThemeMode get themeMode {
    switch (_theme) {
      case AppTheme.dark:
        return ThemeMode.dark;
      case AppTheme.light:
        return ThemeMode.light;
    }
  }

  /// Use switch to map AppLanguage to Locale
  Locale get locale {
    switch (_language) {
      case AppLanguage.ar:
        return const Locale('ar');
      case AppLanguage.en:
        return const Locale('en');
    }
  }
}
