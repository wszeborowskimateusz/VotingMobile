part of 'voting.dart';

Voting _$VotingFromJson(Map<String, dynamic> json) {
  return Voting(
    id: json['id'] as int,
    name: json['name'] as String,
    majority:
        const VotingMajorityConverter().fromJson(json['majority'] as String),
    cardinality: const VotingCardinalityConverter()
        .fromJson(json['cardinality'] as String),
    secrecy: json['secrecy'] as bool,
    status: const VotingStatusConverter().fromJson(json['status'] as String),
    options: (json['options'] as List)
        ?.map((e) => e == null ? null : VotingOption.fromJson(e))
        ?.toList(),
    results:
        Voting._votingResultsFromJson(json['results'], json['cardinality']),
  );
}
