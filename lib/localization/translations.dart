import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings.dart';

class Translations {
  final Locale locale;

  const Translations(this.locale);

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String get title => GetIt.instance.get<TranslationStrings>().appTitle;
}