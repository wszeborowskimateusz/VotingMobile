import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/ui/multiple_choice_voting_results_box.dart';
import 'package:votingmobile/voting/ui/vote_button.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

class VotingsHistoryListWidget extends StatelessWidget {
  final List<Voting> historyVotings;
  final Voting activeVoting;

  VotingsHistoryListWidget({@required this.historyVotings, this.activeVoting});

  @override
  Widget build(BuildContext context) {
    if (activeVoting == null && historyVotings.isEmpty) {
      return Center(
        child: Text(
          Translations.of(context).noVotings,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    }

    return Stack(children: [
      if (historyVotings.isNotEmpty)
        _VotingsHistory(historyVotings: historyVotings),
      if (historyVotings.isEmpty)
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
    @required this.historyVotings,
  }) : super(key: key);

  final List<Voting> historyVotings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 16.0),
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
              final Voting voting = historyVotings[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0).copyWith(
                    bottom: index == historyVotings.length - 1 ? 100 : 16),
                child: voting.cardinality == VotingCardinality.MULTIPLE_CHOICE
                    ? MultipleChoiceVotingResultsBox(voting: voting)
                    : VotingResultsBox(
                        votingName: voting.name,
                        votingResults: voting.results[0],
                      ),
              );
            },
            itemCount: historyVotings.length,
          ),
        ),
      ],
    );
  }
}
