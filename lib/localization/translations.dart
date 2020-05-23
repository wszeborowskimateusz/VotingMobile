import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings.dart';

class Translations implements TranslationStrings {
  final Locale locale;

  const Translations(this.locale);

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  @override
  String get appTitle => locator.get<TranslationStrings>().appTitle;

  @override
  String get settings => locator.get<TranslationStrings>().settings;

  @override
  String get language => locator.get<TranslationStrings>().language;

  @override
  String get vote => locator.get<TranslationStrings>().vote;

  @override
  String get votingsHistory => locator.get<TranslationStrings>().votingsHistory;

  @override
  String get noVotings => locator.get<TranslationStrings>().noVotings;

  @override
  String get noVotingsHistory =>
      locator.get<TranslationStrings>().noVotingsHistory;

  @override
  String get voteAgainst => locator.get<TranslationStrings>().voteAgainst;

  @override
  String get voteHold => locator.get<TranslationStrings>().voteHold;

  @override
  String get voteInFavor => locator.get<TranslationStrings>().voteInFavor;
}
