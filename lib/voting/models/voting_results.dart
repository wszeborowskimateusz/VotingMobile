import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

  @override
  List<Object> get props => [inFavor, against, hold, wasSuccessful, optionId];
}
