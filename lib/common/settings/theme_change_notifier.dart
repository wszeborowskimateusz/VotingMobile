import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:votingmobile/common/backend/theme_repository.dart';
import 'package:votingmobile/common/locator/locator.dart';

class ThemeChangeNotifier extends ChangeNotifier {
  final ThemeRepository _themeRepository = locator.get();

  ThemeMode _selectedTheme;

  ThemeChangeNotifier() {
    _themeRepository.getThemeFromStorage().then((value) {
      _selectedTheme = value;
    });
  }

  ThemeMode get selectedTheme => _selectedTheme;

  Future<void> changeTheme(ThemeMode newTheme) async {
    _selectedTheme = newTheme;
    await _themeRepository.setTheme(newTheme);
    notifyListeners();
  }
}
