// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotingResults _$VotingResultsFromJson(Map<String, dynamic> json) {
  return VotingResults(
    inFavor: json['inFavor'] as int,
    against: json['against'] as int,
    hold: json['hold'] as int,
    wasSuccessful: json['wasSuccessful'] as bool,
    optionId: json['optionId'] as int,
  );
}
