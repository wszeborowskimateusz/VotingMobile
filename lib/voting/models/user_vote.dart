import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:votingmobile/voting/models/vote_type.dart';

part 'user_vote.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
@VoteTypeConverter()
class UserVote {
  final int optionId;
  final VoteType vote;

  const UserVote({this.optionId, @required this.vote});

  Map<String, dynamic> toJson() => _$UserVoteToJson(this);
}
