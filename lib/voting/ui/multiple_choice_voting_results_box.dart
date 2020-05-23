import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

class MultipleChoiceVotingResultsBox extends StatefulWidget {
  final Voting voting;

  const MultipleChoiceVotingResultsBox({@required this.voting});

  @override
  _MultipleChoiceVotingResultsBoxState createState() =>
      _MultipleChoiceVotingResultsBoxState();
}

class _MultipleChoiceVotingResultsBoxState
    extends State<MultipleChoiceVotingResultsBox> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.voting.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        CarouselSlider.builder(
          itemCount: widget.voting.options.length,
          itemBuilder: (context, index) {
            final VotingOption option = widget.voting.options[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: VotingResultsBox(
                votingName: option.name,
                votingResults: widget.voting.results
                    .firstWhere((element) => element.optionId == option.id),
              ),
            );
          },
          options: CarouselOptions(
              height: VotingResultsBox.boxHeight,
              initialPage: 0,
              autoPlay: false,
              pageViewKey: PageStorageKey(widget.voting.id),
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        _DotsIndicator(options: widget.voting.options, current: _current),
      ],
    );
  }
}

class _DotsIndicator extends StatefulWidget {
  const _DotsIndicator({
    Key key,
    @required this.options,
    @required int current,
  })  : _current = current,
        super(key: key);

  final List<VotingOption> options;
  final int _current;

  @override
  __DotsIndicatorState createState() => __DotsIndicatorState();
}

class __DotsIndicatorState extends State<_DotsIndicator>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.options.map((option) {
        final int index = widget.options.indexOf(option);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget._current == index
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
