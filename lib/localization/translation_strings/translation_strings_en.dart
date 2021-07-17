import 'package:votingmobile/localization/translations.dart';

class TranslationStringsEn extends Translations {
  @override
  String get appTitle => "Voting";

  @override
  String get settings => "Settings";

  @override
  String get language => "Language";

  @override
  String get vote => "Vote";

  @override
  String get next => "Next";

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
  String singleVoteInfo(String voteType) => "Are you sure you want to vote: $voteType ?";

  @override
  String get voteAccept => "Accept";

  @override
  String get voteCancel => "Cancel";

  @override
  String get login => "Login";

  @override
  String get loginDisclaimer =>
      "Use the credentials received at the begining of the voting session to log in.";

  @override
  String get loginIncorrectUsernameOrPassword => "Incorrect username or password";

  @override
  String get loginIncorrectNoSession =>
      "There is no session in progress. Wait for the lead to start a session.";

  @override
  String get loginIncorrectUserBlocked => "Your account is blocked";

  @override
  String get password => "Password";

  @override
  String get username => "Username";

  @override
  String get logout => "Logout";

  @override
  String get noActiveVotingDisclaimer =>
      "The voting you are trying to vote for is no longer active";

  @override
  String get goToVoting => "Go to Voting!";

  @override
  String get activeVoting => "Active Voting";

  @override
  String get emptyVote => "Are you sure you want to give an empty vote ?";

  @override
  String get noCurrentActiveVotingDisclaimer =>
      "Curently there is no active voting or you have already voted";

  @override
  String get darkTheme => "Dark";

  @override
  String get lightTheme => "Light";

  @override
  String get theme => "Theme";
}
