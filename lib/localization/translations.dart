import 'package:flutter/material.dart';

class Translations {
  final Locale locale;

  const Translations(this.locale);

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
    },
    'pl': {
      'title': 'Witaj Świecie',
    },
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
}