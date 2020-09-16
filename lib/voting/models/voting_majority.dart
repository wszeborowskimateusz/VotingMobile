import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voting_majority.g.dart';

class VotingMajority extends EnumClass {
  static const VotingMajority RELATIVE = _$relative;
  static const VotingMajority ABSOLUTE = _$absolute;
  static const VotingMajority TWO_THIRDS = _$twoThirds;

  const VotingMajority._(String name) : super(name);

  static BuiltSet<VotingMajority> get values => _$values;
  static VotingMajority valueOf(String name) => _$valueOf(name);
  static VotingMajority fromJson(dynamic json) => valueOf(json);

  String toJson() => name;
}

class VotingMajorityConverter implements JsonConverter<VotingMajority, String> {
  const VotingMajorityConverter();

  @override
  VotingMajority fromJson(String json) {
    if (json == null) return null;

    return VotingMajority.fromJson(json);
  }

  @override
  String toJson(VotingMajority object) {
    return object?.toJson();
  }
}
