import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voting_status.g.dart';

class VotingStatus extends EnumClass {
  static const VotingStatus FINISHED = _$finished;
  static const VotingStatus NOT_STARTED = _$notStarted;
  static const VotingStatus DURING_VOTING = _$duringVoting;

  const VotingStatus._(String name) : super(name);

  static BuiltSet<VotingStatus> get values => _$values;
  static VotingStatus valueOf(String name) => _$valueOf(name);
  static VotingStatus fromJson(dynamic json) => valueOf(json);

  String toJson() => name;
}

class VotingStatusConverter implements JsonConverter<VotingStatus, String> {
  const VotingStatusConverter();

  @override
  VotingStatus fromJson(String json) {
    if (json == null) return null;

    return VotingStatus.fromJson(json);
  }

  @override
  String toJson(VotingStatus object) {
    return object?.toJson();
  }
}
