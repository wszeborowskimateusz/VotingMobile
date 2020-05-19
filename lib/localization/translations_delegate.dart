import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings_pl.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings_en.dart';
import 'package:votingmobile/localization/translations.dart';

final List<Locale> supportedLocales = [
  const Locale('en'),
  const Locale('pl'),
];

final Locale defaultLocale = Locale('en');

TranslationStrings getTranslationsForLocale(Locale locale) {
  switch (locale.languageCode) {
    case "pl":
      return TranslationStringsPl();
    case "en":
    default:
      return TranslationStringsEn();
  }
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => supportedLocales
      .map((Locale locale) => locale.languageCode)
      .contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) {
    return SynchronousFuture<Translations>(Translations(locale));
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
