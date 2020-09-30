import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vote_type.g.dart';

class VoteType extends EnumClass {
  static const VoteType FOR = _$for;
  static const VoteType AGAINST = _$against;
  static const VoteType HOLD = _$hold;
  static const VoteType NO_VOTE = _$noVote;

  const VoteType._(String name) : super(name);

  static BuiltSet<VoteType> get values => _$values;
  static VoteType valueOf(String name) => _$valueOf(name);
  static VoteType fromJson(dynamic json) => valueOf(json);

  String toJson() => name;
}

class VoteTypeConverter implements JsonConverter<VoteType, String> {
  const VoteTypeConverter();

  @override
  VoteType fromJson(String json) {
    if (json == null) return null;

    return VoteType.fromJson(json);
  }

  @override
  String toJson(VoteType object) {
    return object?.toJson();
  }
}
