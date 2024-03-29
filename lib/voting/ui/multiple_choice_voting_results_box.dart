import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/ui/dots_indicator.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

class MultipleChoiceVotingResultsBox extends StatefulWidget {
  final Voting voting;

  const MultipleChoiceVotingResultsBox({@required this.voting});

  @override
  _MultipleChoiceVotingResultsBoxState createState() => _MultipleChoiceVotingResultsBoxState();
}

class _MultipleChoiceVotingResultsBoxState extends State<MultipleChoiceVotingResultsBox> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

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
        Container(
          constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth - 200),
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.voting.options.length,
            itemBuilder: (context, index, _) {
              final VotingOption option = widget.voting.options[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: VotingResultsBox(
                  votingName: option.name,
                  votingResults: widget.voting.results[option.id],
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
        ),
        DotsIndicator<VotingOption>(
          options: widget.voting.options,
          current: _current,
          onDotTap: (index) => _carouselController.animateToPage(index),
        ),
      ],
    );
  }
}
