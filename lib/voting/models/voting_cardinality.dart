import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voting_cardinality.g.dart';

class VotingCardinality extends EnumClass {
  static const VotingCardinality SINGLE_CHOICE = _$singleChoice;
  static const VotingCardinality MULTIPLE_CHOICE = _$multipleChoice;

  const VotingCardinality._(String name) : super(name);

  static BuiltSet<VotingCardinality> get values => _$values;
  static VotingCardinality valueOf(String name) => _$valueOf(name);
  static VotingCardinality fromJson(dynamic json) => valueOf(json);

  String toJson() => name;
}

class VotingCardinalityConverter implements JsonConverter<VotingCardinality, String> {
  const VotingCardinalityConverter();

  @override
  VotingCardinality fromJson(String json) {
    if (json == null) return null;

    return VotingCardinality.fromJson(json);
  }

  @override
  String toJson(VotingCardinality object) {
    return object?.toJson();
  }
}
