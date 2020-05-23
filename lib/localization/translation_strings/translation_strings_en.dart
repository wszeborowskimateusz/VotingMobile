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
}