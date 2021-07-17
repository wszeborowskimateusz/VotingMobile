import 'dart:async';

import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/voting/backend/votings_api.dart';
import 'package:votingmobile/voting/models/user_votes.dart';
import 'package:votingmobile/voting/models/voting.dart';
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
    await updateActiveVoting();
    _activeActiveVotingTimer = Timer.periodic(Duration(seconds: 30), (_) async {
      await updateActiveVoting();
    });
  }

  Future<void> updateActiveVoting() async {
    if (locator.get<UserRepository>().isLoggedIn) {
      final Voting newActiveVoting = await _votingsApi.getActiveVoting();
      if (_activeVoting != newActiveVoting) {
        _activeVoting = newActiveVoting;
        notifyListeners();
      }
    }
  }

  Future<void> vote(UserVotes votes) async {
    assert(_activeVoting != null, "You can only vote when some voting is active");
    await _votingsApi.vote(_activeVoting.id, votes);
    _activeVoting = null;
    notifyListeners();
  }
}

class VotingsRepository {
  final VotingsApi _votingsApi = locator.get();

  Future<List<Voting>> getVotingsHistory() async {
    final votings = await _votingsApi.getVotings();
    return votings.where((v) => v.status == VotingStatus.FINISHED).toList();
  }
}
