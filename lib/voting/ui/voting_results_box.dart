import 'package:flutter/material.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/voting/models/voting_results.dart';

class VotingResultsBox extends StatelessWidget {
  static const double boxHeight = 150;

  final String votingName;
  final VotingResults votingResults;

  const VotingResultsBox({
    @required this.votingName,
    @required this.votingResults,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth - 200),
          margin: EdgeInsets.symmetric(horizontal: 12),
          height: boxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0)
                .copyWith(left: _getBadgeHeight(context), right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  votingName,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                    height: 5,
                    width: 25,
                    color: votingResults.wasSuccessful
                        ? Colors.green
                        : Colors.red),
                _VotingNumericResults(votingResults: votingResults),
              ],
            ),
          ),
        ),
        _ResultBadge(votingResults: votingResults),
      ],
    );
  }
}

double _getBadgeHeight(context) => VotingResultsBox.boxHeight * 0.6;

class _VotingNumericResults extends StatelessWidget {
  const _VotingNumericResults({
    @required this.votingResults,
  });

  final VotingResults votingResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildResultInfo("assets/images/successful.png", votingResults.inFavor),
        _buildResultInfo(
            "assets/images/unsuccessful.png", votingResults.against),
        _buildResultInfo("assets/images/hold.png", votingResults.hold),
      ],
    );
  }

  Widget _buildResultInfo(String imagePath, int amountOfVotes) {
    return Row(children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 2.0, bottom: 4.0),
          child: Image.asset(
            imagePath,
            height: 24,
          )),
      Text(amountOfVotes.toString()),
    ]);
  }
}

class _ResultBadge extends StatelessWidget {
  const _ResultBadge({
    @required this.votingResults,
  });

  final VotingResults votingResults;

  @override
  Widget build(BuildContext context) {
    final double badgeHeight = _getBadgeHeight(context);
    return Positioned(
      left: 0,
      top: VotingResultsBox.boxHeight / 2 - (badgeHeight / 2),
      child: Image.asset(
        votingResults.wasSuccessful
            ? "assets/images/successful.png"
            : "assets/images/unsuccessful.png",
        height: badgeHeight,
        width: badgeHeight,
      ),
    );
  }
}
