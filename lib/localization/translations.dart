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
  String get next => locator.get<TranslationStrings>().next;

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
    if (voteType == null) {
      return emptyVote;
    }
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
  String get loginIncorrectUserBlocked =>
      locator.get<TranslationStrings>().loginIncorrectUserBlocked;

  @override
  String get loginIncorrectNoSession =>
      locator.get<TranslationStrings>().loginIncorrectNoSession;

  @override
  String get password => locator.get<TranslationStrings>().password;

  @override
  String get username => locator.get<TranslationStrings>().username;

  @override
  String get logout => locator.get<TranslationStrings>().logout;

  @override
  String get noActiveVotingDisclaimer =>
      locator.get<TranslationStrings>().noActiveVotingDisclaimer;

  @override
  String get goToVoting => locator.get<TranslationStrings>().goToVoting;

  @override
  String get activeVoting => locator.get<TranslationStrings>().activeVoting;

  @override
  String get emptyVote => locator.get<TranslationStrings>().emptyVote;

  @override
  String get noCurrentActiveVotingDisclaimer =>
      locator.get<TranslationStrings>().noCurrentActiveVotingDisclaimer;
}
