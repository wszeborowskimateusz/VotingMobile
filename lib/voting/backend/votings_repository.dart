import 'dart:async';

import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/voting/backend/votings_api.dart';
import 'package:votingmobile/voting/models/user_votes.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/models/voting_majority.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/models/voting_results.dart';
import 'package:votingmobile/voting/models/voting_status.dart';

class ActiveVoting extends ChangeNotifier {
  final VotingsApi _votingsApi = locator.get();

  Voting _activeVoting;
  Timer _activeActiveVotingTimer;

  ActiveVoting() {
    _startFetchingActiveVoting();
  }

  Voting get activeVoting => _activeVoting;

  @override
  void dispose() {
    _activeActiveVotingTimer.cancel();
    super.dispose();
  }

  void _startFetchingActiveVoting() async {
    if (locator.get<UserRepository>().isLoggedIn) {
      _activeVoting = await _votingsApi.getActiveVoting();
    }
    _activeActiveVotingTimer = Timer.periodic(Duration(seconds: 30), (_) async {
      if (locator.get<UserRepository>().isLoggedIn) {
        final Voting newActiveVoting = await _votingsApi.getActiveVoting();
        if (_activeVoting != newActiveVoting) {
          _activeVoting = newActiveVoting;
          notifyListeners();
        }
      }
    });
  }

  Future<void> vote(UserVotes votes) async {
    // TODO: Think of a situation when we send a vote but the voting is already finished
    assert(
        _activeVoting != null, "You can only vote when some voting is active");
    await _votingsApi.vote(_activeVoting.id, votes);
    _activeVoting = null;
    notifyListeners();
  }
}

class VotingsRepository {
  // Voting here should only be in a FINISHED status
  List<Voting> getVotingsHistory() {
    return _testVotings;
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
