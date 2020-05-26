import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';

typedef StringGetter = String Function(BuildContext);

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

  String get voteCancel;

  String get voteAccept;

  String singleVoteInfo(String voteType);

  String multipleVoteInfo(int votedAnswersAmount, int allQuestionsAmount);

  String get username;

  String get password;

  String get login;
  
  String get loginDisclaimer;
  
  String get loginIncorrectUsernameOrPassword;

  String get logout;

  String get noActiveVotingDisclaimer;
}
