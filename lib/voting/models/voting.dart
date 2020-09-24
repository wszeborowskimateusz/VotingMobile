import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/models/voting_majority.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/models/voting_results.dart';
import 'package:votingmobile/voting/models/voting_status.dart';

part 'voting.g.dart';

// @JsonSerializable(createToJson: false)
@VotingMajorityConverter()
@VotingCardinalityConverter()
@VotingStatusConverter()
class Voting extends Equatable {
  final int id;
  final String name;
  final VotingMajority majority;
  final VotingCardinality cardinality;
  final bool secrecy;
  final VotingStatus status;
  final List<VotingOption> options;
  @JsonKey(fromJson: _votingResultsFromJson)
  final dynamic results;

  const Voting({
    @required this.id,
    @required this.name,
    @required this.majority,
    @required this.cardinality,
    @required this.secrecy,
    @required this.status,
    @required this.options,
    this.results,
  }) : assert(
            status != VotingStatus.FINISHED ||
                (status == VotingStatus.FINISHED && results != null),
            "When voting is finished it should have result");

  factory Voting.fromJson(dynamic json) => _$VotingFromJson(json);

  @override
  List<Object> get props => [
        id,
        name,
        majority,
        cardinality,
        secrecy,
        status,
        options,
        results,
      ];

  static _votingResultsFromJson(dynamic json, String cardinalityJson) {
    final cardinality = VotingCardinality.fromJson(cardinalityJson);

    assert(VotingCardinality.values.contains(cardinality));

    if (cardinality == VotingCardinality.SINGLE_CHOICE) {
      return VotingResults.fromJson(json);
    }

    final jsonWithResults = {'results': json};
    return VotingResultsForMultipleChoice.fromJson(jsonWithResults).results;
  }
}
