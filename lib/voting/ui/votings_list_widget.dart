import 'package:flutter/material.dart';
import 'package:votingmobile/voting/models/voting.dart';

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
    final List<Voting> pastVotings = votings..remove(activeVoting);
    if (activeVoting == null && pastVotings.isEmpty) {
      return Center(
        child: Text(""),
      );
    }

    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (pastVotings.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Votings History",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          if (pastVotings.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 1.0)
                        .copyWith(
                            bottom: index == pastVotings.length - 1 ? 100 : 16),
                    child: _ElevatedContainer(),
                  );
                },
                itemCount: pastVotings.length,
              ),
            ),
        ],
      ),
      if (activeVoting != null)
        Positioned(
          bottom: 16,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: _ActiveVoting(activeVoting),
          ),
        ),
    ]);
  }
}

class _ActiveVoting extends StatelessWidget {
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(8.0));

  final Voting activeVoting;

  const _ActiveVoting(this.activeVoting);

  @override
  Widget build(BuildContext context) {
    //TODO: Handle situation when we have active voting and user has alreade voted in it
    return RaisedButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {},
      elevation: 15.0,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff4169E1), Color(0xff20b2aa)]),
          borderRadius: _borderRadius,
        ),
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width - 32.0,
          alignment: Alignment.center,
          child: Text(
            "Vote",
            style: Theme.of(context).primaryTextTheme.button.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

class _ElevatedContainer extends StatelessWidget {
  final Widget child;

  const _ElevatedContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
