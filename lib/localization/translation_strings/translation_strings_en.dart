import 'package:votingmobile/localization/translation_strings/translation_strings.dart';

class TranslationStringsEn implements TranslationStrings {
  @override
  String get appTitle => "Voting";

  @override
  String get settings => "Settings";

  @override
  String get language => "Language";

  @override
  String get vote => "Vote";

  @override
  String get votingsHistory => "Votings History";

  @override
  String get noVotings => "Wait for the election lead to start a voting";

  @override
  String get noVotingsHistory => "No Votings History";

  @override
  String get voteAgainst => "Against";

  @override
  String get voteHold => "Hold";

  @override
  String get voteInFavor => "In favor";

  @override
  String multipleVoteInfo(int votedAnswersAmount, int allQuestionsAmount) =>
      "Are you sure you want to vote for $votedAnswersAmount / $allQuestionsAmount options ?";

  @override
  String singleVoteInfo(String voteType) =>
      "Are you sure you want to vote: $voteType ?";

  @override
  String get voteAccept => "Accept";

  @override
  String get voteCancel => "Cancel";
}
