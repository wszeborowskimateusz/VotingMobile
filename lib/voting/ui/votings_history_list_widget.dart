import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/ui/multiple_choice_voting_results_box.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

class VotingsHistoryListWidget extends StatefulWidget {
  VotingsHistoryListWidget();

  @override
  _VotingsHistoryListWidgetState createState() =>
      _VotingsHistoryListWidgetState();
}

class _VotingsHistoryListWidgetState extends State<VotingsHistoryListWidget> {
  final VotingsRepository _votingsRepository = locator.get<VotingsRepository>();

  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveVoting>(
      builder: (context, activeVotingModel, _) => _buildWidget(
        context,
        child: FutureBuilder(
          future: _votingsRepository.getVotingsHistory(),
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print(snapshot.error);
            }

            final historyVotings = snapshot.hasError ? [] : snapshot.data;
            return activeVotingModel.activeVoting == null &&
                    historyVotings.isEmpty
                ? NoActiveVotingNoVotingsHistory()
                : historyVotings.isEmpty
                    ? _NoVotingsHistory()
                    : _VotingsHistory(historyVotings: historyVotings);
          },
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, {@required Widget child}) {
    return CommonLayout(
      leftIcon: _isRefreshing
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4169E1)),
              ),
            )
          : IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _refreshState(context);
              },
              color: Color(0xff4169E1),
            ),
      displayVoteSheet: true,
      body: Consumer<ActiveVoting>(
        builder: (context, activeVotingModel, _) => Column(
          children: [
            _PageTitle(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 60.0),
                child: child,
              ),
            ),
          ],
        ),
      ),
      displayLeftBackIcon: false,
    );
  }

  void _refreshState(BuildContext context) async {
    setState(() {
      _isRefreshing = true;
    });
    await Provider.of<ActiveVoting>(context, listen: false)
        .updateActiveVoting();
    setState(() {
      _isRefreshing = false;
    });
  }
}

@visibleForTesting
class NoActiveVotingNoVotingsHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Translations.of(context).noVotings,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class _NoVotingsHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _PageTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      Translations.of(context).votingsHistory,
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontWeight: FontWeight.bold),
    );
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
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Voting voting = historyVotings[index];
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: voting.cardinality == VotingCardinality.MULTIPLE_CHOICE
              ? MultipleChoiceVotingResultsBox(voting: voting)
              : VotingResultsBox(
                  votingName: voting.name,
                  votingResults: voting.results,
                ),
        );
      },
      itemCount: historyVotings.length,
    );
  }
}
