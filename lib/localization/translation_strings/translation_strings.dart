import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class TranslationStrings {
  static TranslationStrings of(BuildContext context) {
    return GetIt.instance.get<TranslationStrings>();
  }

  String get appTitle;
}