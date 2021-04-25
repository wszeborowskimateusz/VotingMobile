import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

class LocaleRepository {
  static const String _selectedLocaleStorageKey = 'selectedLocale';

  Locale _selectedLocale;

  Locale get selectedLocale => _selectedLocale;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String localeAsString = prefs.getString(_selectedLocaleStorageKey) ??
        defaultLocale.languageCode;
    _selectedLocale = Locale(localeAsString);
  }

  Future<void> setLocale(Locale locale) async {
    locator.get<TranslationsDelegate>().load(locale);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String localeAsString = locale.languageCode;
    await prefs.setString(_selectedLocaleStorageKey, localeAsString);
    _selectedLocale = locale;
  }
}
