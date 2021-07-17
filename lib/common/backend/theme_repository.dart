import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static const String _selectedThemeStorageKey = 'selectedTheme';
  static const String _lightKey = 'light';
  static const String _darkKey = 'dark';

  Future<ThemeMode> getThemeFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String themeAsString =
        prefs.getString(_selectedThemeStorageKey) ?? _lightKey;
    return themeAsString == _lightKey ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> setTheme(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String themeAsString = theme == ThemeMode.light ? _lightKey : _darkKey;
    await prefs.setString(_selectedThemeStorageKey, themeAsString);
  }
}
