import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';

abstract class TranslationStrings {
  static TranslationStrings of(BuildContext context) {
    return locator.get<TranslationStrings>();
  }

  String get appTitle;

  String get settings;

  String get language;
}