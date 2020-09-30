import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voting_results.g.dart';

@JsonSerializable(createToJson: false)
class VotingResults extends Equatable {
  final int inFavor;
  final int against;
  final int hold;
  final bool wasSuccessful;
  final int optionId;

  const VotingResults({
    @required this.inFavor,
    @required this.against,
    @required this.hold,
    @required this.wasSuccessful,
    this.optionId,
  });

  factory VotingResults.fromJson(dynamic json) => _$VotingResultsFromJson(json);

  @override
  List<Object> get props => [inFavor, against, hold, wasSuccessful, optionId];
}

@JsonSerializable(createToJson: false)
class VotingResultsForMultipleChoice extends Equatable {
  final Map<int, VotingResults> results;

  const VotingResultsForMultipleChoice({
    @required this.results,
  });

  factory VotingResultsForMultipleChoice.fromJson(dynamic json) =>
      _$VotingResultsForMultipleChoiceFromJson(json);

  @override
  List<Object> get props => [results];
}
