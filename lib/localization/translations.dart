import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings.dart';
import 'package:votingmobile/voting/models/vote_type.dart';

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

  @override
  String multipleVoteInfo(int votedAnswersAmount, int allQuestionsAmount) =>
      locator
          .get<TranslationStrings>()
          .multipleVoteInfo(votedAnswersAmount, allQuestionsAmount);

  @override
  String singleVoteInfo(String voteType) =>
      locator.get<TranslationStrings>().singleVoteInfo(voteType);

  @override
  String get voteAccept => locator.get<TranslationStrings>().voteAccept;

  @override
  String get voteCancel => locator.get<TranslationStrings>().voteCancel;

  String getTranslationForVoteType(VoteType voteType) {
    switch (voteType) {
      case VoteType.FOR:
        return voteInFavor;
      case VoteType.AGAINST:
        return voteAgainst;
      case VoteType.HOLD:
        return voteHold;
    }

    throw ArgumentError("Given type $voteType is not supported");
  }

  @override
  String get login => locator.get<TranslationStrings>().login;

  @override
  String get loginDisclaimer =>
      locator.get<TranslationStrings>().loginDisclaimer;

  @override
  String get loginIncorrectUsernameOrPassword =>
      locator.get<TranslationStrings>().loginIncorrectUsernameOrPassword;

  @override
  String get password => locator.get<TranslationStrings>().password;

  @override
  String get username => locator.get<TranslationStrings>().username;

  @override
  String get logout => locator.get<TranslationStrings>().logout;
}
