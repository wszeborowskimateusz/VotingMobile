import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:votingmobile/voting/models/user_vote.dart';

part 'user_votes.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class UserVotes {
  final List<UserVote> votes;

  const UserVotes({@required this.votes});

  Map<String, dynamic> toJson() => _$UserVotesToJson(this);
}
