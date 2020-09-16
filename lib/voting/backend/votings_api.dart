import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/voting/models/user_votes.dart';
import 'package:votingmobile/voting/models/voting.dart';

class VotingsApi {
  final CommonHttpClient _httpClient = locator.get();

  Future<Voting> getActiveVoting() async {
    return _httpClient.get(
      url: '/votes/active',
      responseParser: (dynamic json) => Voting.fromJson(json),
    );
  }

  Future<void> vote(int votingId, UserVotes votes) async {
    return _httpClient.post(
      url: '/votes/vote/$votingId',
      body: votes.toJson(),
    );
  }
}
