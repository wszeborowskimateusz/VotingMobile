import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/ui/votings_list_widget.dart';

class MainWidget extends StatelessWidget {
  final List<Voting> testVotings = [
    Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
        Voting(
      id: 1,
      name: "Czy zgadzasz się ze mną",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.FINISHED,
    ),
      Voting(
      id: 2,
      name: "Czy zgadzasz się z nim",
      cardinality: VotingCardinality.SINGLE_CHOICE,
      options: [],
      electionLeadId: 2,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      status: VotingStatus.DURING_VOTING,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      displayLeftIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(top: 0.0),
        child: VotingsListWidget(testVotings),
      ),
    );
  }
}
