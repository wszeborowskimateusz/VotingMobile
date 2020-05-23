import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/ui/multiple_choice_voting_results_box.dart';
import 'package:votingmobile/voting/ui/vote_button.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

class VotingsListWidget extends StatelessWidget {
  final List<Voting> votings;
  final Voting activeVoting;

  VotingsListWidget(this.votings)
      : activeVoting = votings.firstWhere(
            (element) => element.status == VotingStatus.DURING_VOTING,
            orElse: () => null);

  @override
  Widget build(BuildContext context) {
    // TODO: Handle empty list - display info that user needs to wait for the start of
    // the first voting
    final List<Voting> pastVotings = votings.toList()..remove(activeVoting);
    if (activeVoting == null && pastVotings.isEmpty) {
      return Center(
        child: Text(
          Translations.of(context).noVotings,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    }

    return Stack(children: [
      if (pastVotings.isNotEmpty) _VotingsHistory(pastVotings: pastVotings),
      if (pastVotings.isEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  Translations.of(context).noVotingsHistory,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        ),
      if (activeVoting != null)
        Positioned(
          bottom: 16,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: VoteButton(),
          ),
        ),
    ]);
  }
}

class _VotingsHistory extends StatelessWidget {
  const _VotingsHistory({
    Key key,
    @required this.pastVotings,
  }) : super(key: key);

  final List<Voting> pastVotings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            Translations.of(context).votingsHistory,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final Voting voting = pastVotings[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0).copyWith(
                    bottom: index == pastVotings.length - 1 ? 100 : 16),
                child: voting.cardinality == VotingCardinality.MULTIPLE_CHOICE
                    ? MultipleChoiceVotingResultsBox(voting: voting)
                    : VotingResultsBox(
                        votingName: voting.name,
                        votingResults: voting.results[0],
                      ),
              );
            },
            itemCount: pastVotings.length,
          ),
        ),
      ],
    );
  }
}
