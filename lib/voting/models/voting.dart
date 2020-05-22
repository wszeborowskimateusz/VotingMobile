import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:votingmobile/voting/models/voting_option.dart';

class Voting extends Equatable {
  final int id;
  final String name;
  final VotingMajority majority;
  final VotingCardinality cardinality;
  final bool secrecy;
  final VotingStatus status;
  final List<VotingOption> options;
  final int threshold;
  final int electionLeadId;

  const Voting({
    @required this.id,
    @required this.name,
    @required this.majority,
    @required this.cardinality,
    @required this.secrecy,
    @required this.status,
    @required this.options,
    this.threshold,
    @required this.electionLeadId,
  });

  @override
  List<Object> get props => [
        id,
        name,
        majority,
        cardinality,
        secrecy,
        status,
        options,
        threshold,
        electionLeadId,
      ];
}

enum VotingMajority { RELATIVE, ABSOLUTE, TWO_THIRDS }

enum VotingCardinality { SINGLE_CHOICE, MULTIPLE_CHOICE }

enum VotingStatus {
  FINISHED,
  // This one will probably be never send to mobile app
  NOT_STARTED,
  DURING_VOTING
}
