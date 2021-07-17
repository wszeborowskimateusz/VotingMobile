import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voting_option.g.dart';

@JsonSerializable(createToJson: false)
class VotingOption extends Equatable {
  final int id;
  final String name;

  const VotingOption({@required this.id, @required this.name});

  factory VotingOption.fromJson(dynamic json) => _$VotingOptionFromJson(json);

  @override
  List<Object> get props => [id, name];
}
