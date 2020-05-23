import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/models/voting_results.dart';

class VotingsRepository {
  Voting _activeVoting = _testActiveVoting;

  // Voting here should only be in a FINISHED status
  List<Voting> getVotingsHistory() {
    return _testVotings;
  }

  Voting get activeVoting => _activeVoting;

  void vote() {
    // TODO: Think of a situation when we send a vote but the voting is already finished
    assert(
        _activeVoting == null, "You can only vote when some voting is active");
    // TODO: Send a real request
    _activeVoting = null;
  }
}

final List<Voting> _testVotings = [
  Voting(
    id: 2,
    name:
        "Głosowanie ws. wyboru członków Komisji Prawno Rewizyjnej: kandydat(ka)",
    cardinality: VotingCardinality.MULTIPLE_CHOICE,
    options: [
      VotingOption(id: 1, name: "Anna Winiarska"),
      VotingOption(id: 2, name: "Marta Rutkowska"),
      VotingOption(id: 3, name: "Bartosz Nurek"),
      VotingOption(id: 4, name: "Dawid Krefta"),
    ],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(
        inFavor: 40,
        against: 35,
        hold: 2,
        wasSuccessful: false,
        optionId: 1,
      ),
      VotingResults(
        inFavor: 55,
        against: 7,
        hold: 3,
        wasSuccessful: true,
        optionId: 2,
      ),
      VotingResults(
        inFavor: 10,
        against: 41,
        hold: 5,
        wasSuccessful: false,
        optionId: 3,
      ),
      VotingResults(
        inFavor: 10,
        against: 41,
        hold: 5,
        wasSuccessful: true,
        optionId: 4,
      ),
    ],
  ),
  Voting(
    id: 1,
    name:
        "Głosowanie nad kandydaturą Justyny Jodłowskiej na zastępce ds. socjalnych",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
  Voting(
    id: 3,
    name:
        "Głosowanie ws. wyboru członków Komisji Prawno Rewizyjnej: kandydat(ka)",
    cardinality: VotingCardinality.MULTIPLE_CHOICE,
    options: [
      VotingOption(id: 1, name: "Anna Winiarska"),
      VotingOption(id: 2, name: "Marta Rutkowska"),
      VotingOption(id: 3, name: "Bartosz Nurek"),
      VotingOption(id: 4, name: "Dawid Krefta"),
    ],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(
        inFavor: 40,
        against: 35,
        hold: 2,
        wasSuccessful: false,
        optionId: 1,
      ),
      VotingResults(
        inFavor: 55,
        against: 7,
        hold: 3,
        wasSuccessful: true,
        optionId: 2,
      ),
      VotingResults(
        inFavor: 10,
        against: 41,
        hold: 5,
        wasSuccessful: false,
        optionId: 3,
      ),
      VotingResults(
        inFavor: 10,
        against: 41,
        hold: 5,
        wasSuccessful: true,
        optionId: 4,
      ),
    ],
  ),
  Voting(
    id: 4,
    name:
        "Głosowanie nad kandydaturą Jakuba Persjanowa na zastępce ds. kultury i sportu",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
  Voting(
    id: 5,
    name: "Czy zgadzasz się ze mną",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
  Voting(
    id: 6,
    name: "Czy zgadzasz się ze mną",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
  Voting(
    id: 7,
    name: "Czy zgadzasz się ze mną",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
  Voting(
    id: 8,
    name: "Czy zgadzasz się ze mną",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
  Voting(
    id: 9,
    name: "Czy zgadzasz się ze mną",
    cardinality: VotingCardinality.SINGLE_CHOICE,
    options: [],
    majority: VotingMajority.ABSOLUTE,
    secrecy: false,
    status: VotingStatus.FINISHED,
    results: [
      VotingResults(inFavor: 40, against: 35, hold: 2, wasSuccessful: true)
    ],
  ),
];

final Voting _testActiveVoting = Voting(
  id: 10,
  name: "Głosowanie nad kandydaturą Justyny Jodłowskiej na zastępce ds. socjalnych",
  cardinality: VotingCardinality.SINGLE_CHOICE,
  options: [],
  majority: VotingMajority.ABSOLUTE,
  secrecy: false,
  status: VotingStatus.DURING_VOTING,
);
