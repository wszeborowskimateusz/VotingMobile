import 'package:votingmobile/localization/translation_strings/translation_strings.dart';

class TranslationStringsPl implements TranslationStrings {
  @override
  String get appTitle => "Głosowanie";

  @override
  String get settings => "Ustawienia";

  @override
  String get language => "Język";
  
  @override
  String get vote => "Zagłosuj";

  @override
  String get votingsHistory => "Historia Głosowań";

  @override
  String get noVotings => "Poczekaj aż przewodniczący rozpocznie głosowanie";

  @override
  String get noVotingsHistory => "Brak poprzednich głosowań";
  
  @override
  String get voteAgainst => "Przeciw";

  @override
  String get voteHold => "Wstrzymaj się";

  @override
  String get voteInFavor => "Za";
}