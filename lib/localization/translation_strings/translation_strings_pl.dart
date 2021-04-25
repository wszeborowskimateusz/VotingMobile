import 'package:votingmobile/localization/translations.dart';

class TranslationStringsPl extends Translations {
  @override
  String get appTitle => "Głosowanie";

  @override
  String get settings => "Ustawienia";

  @override
  String get language => "Język";

  @override
  String get vote => "Zagłosuj";
  
  @override
  String get next => "Następny";

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

  @override
  String multipleVoteInfo(int votedAnswersAmount, int allQuestionsAmount) =>
      "Czy na pewno chcesz zagłosować na $votedAnswersAmount / $allQuestionsAmount opcji ?";

  @override
  String singleVoteInfo(String voteType) =>
      "Czy na pewno chcesz zagłosować: $voteType ?";

  @override
  String get voteAccept => "Zaakceptuj";

  @override
  String get voteCancel => "Anuluj";

  @override
  String get login => "Zaloguj się";

  @override
  String get loginDisclaimer =>
      "Użyj nazwy użytkownika i hasła otrzymanego na początku posiedzenia.";

  @override
  String get loginIncorrectUsernameOrPassword =>
      "Nieprawidłowa nazwa użytkownika lub hasło";

      
  @override
  String get loginIncorrectNoSession =>
      "Nie trwa obecnie żadne posiedzenie. Zaczekaj aż przewodniczący rozpocznie posiedzenie.";

  @override
  String get loginIncorrectUserBlocked => "Twoje konto jest zablokowane";

  @override
  String get password => "Hasło";

  @override
  String get username => "Nazwa użytkownika";

  @override
  String get logout => "Wyloguj się";

  @override
  String get noActiveVotingDisclaimer =>
      "Głosowanie, na które próbujesz zagłosować nie jest już aktywne";

  @override
  String get goToVoting => "Przejdź go głosowania!";

  @override
  String get activeVoting => "Aktywne Głosowanie";

  @override
  String get emptyVote => "Czy na pewno chcesz oddać pusty głos ?";

  @override
  String get noCurrentActiveVotingDisclaimer =>
      "Obecnie nie trwa żadne głosowanie lub już zagłosowałeś";
}
