import 'package:votingmobile/common/http/http_client.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/voting/models/user_votes.dart';
import 'package:votingmobile/voting/models/voting.dart';

class VotingsApi {
  final CommonHttpClient _httpClient = locator.get();

  Future<Voting> getActiveVoting() async {
    return _httpClient
        .get(
          url: '/votes/active',
          responseParser: (dynamic json) =>
              json == null ? null : Voting.fromJson(json),
        )
        .catchError((_) => null);
  }

  Future<void> vote(int votingId, UserVotes votes) async {
    return _httpClient.post(
      url: '/votes/$votingId/vote',
      body: votes.toJson(),
    );
  }

  Future<List<Voting>> getVotings() async {
    return _httpClient.get(
      url: '/votings?includeResults=true',
      responseParser: ((dynamic json) {
        return (json as List)
            ?.map((dynamic jsonVoting) => Voting.fromJson(jsonVoting))
            ?.toList();
      }),
    );
  }
}
