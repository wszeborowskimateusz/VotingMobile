import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/voting/models/vote_type.dart';

typedef StringGetter = String Function(BuildContext);

abstract class Translations {
  static Translations of(BuildContext context) {
    return locator.get<Translations>();
  }

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

  String get appTitle;

  String get settings;

  String get language;

  String get vote;

  String get next;

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

  String get loginIncorrectUserBlocked;
  
  String get loginIncorrectNoSession;

  String get logout;

  String get noActiveVotingDisclaimer;

  String get goToVoting;

  String get activeVoting;

  String get emptyVote;

  String get noCurrentActiveVotingDisclaimer;
}
