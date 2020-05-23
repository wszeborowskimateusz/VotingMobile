import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';

abstract class TranslationStrings {
  static TranslationStrings of(BuildContext context) {
    return locator.get<TranslationStrings>();
  }

  String get appTitle;

  String get settings;

  String get language;

  String get vote;

  String get votingsHistory;

  String get noVotings;

  String get noVotingsHistory;

  String get voteInFavor;

  String get voteAgainst;

  String get voteHold;
}
