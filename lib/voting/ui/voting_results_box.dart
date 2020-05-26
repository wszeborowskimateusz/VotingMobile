import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:votingmobile/voting/models/voting_results.dart';

class VotingResultsBox extends StatelessWidget {
  static const double boxHeight = 150;
  static const double _resultBadgeHeight = 80;

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
          margin: EdgeInsets.symmetric(horizontal: 20),
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
                .copyWith(left: _resultBadgeHeight, right: 16.0),
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
        _buildResultInfo("assets/images/successful.svg", votingResults.inFavor),
        _buildResultInfo(
            "assets/images/unsuccessful.svg", votingResults.against),
        _buildResultInfo("assets/images/hold.svg", votingResults.hold),
      ],
    );
  }

  Widget _buildResultInfo(String imagePath, int amountOfVotes) {
    return Row(children: <Widget>[
      Container(
          margin: EdgeInsets.only(right: 2.0, bottom: 4.0),
          child: SvgPicture.asset(
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
    return Positioned(
      left: 0,
      top: VotingResultsBox.boxHeight / 2 -
          (VotingResultsBox._resultBadgeHeight / 2),
      child: SvgPicture.asset(
        votingResults.wasSuccessful
            ? "assets/images/successful.svg"
            : "assets/images/unsuccessful.svg",
        height: VotingResultsBox._resultBadgeHeight,
      ),
    );
  }
}
