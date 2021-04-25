import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/dots_indicator.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/models/voting_majority.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/models/voting_results.dart';
import 'package:votingmobile/voting/models/voting_status.dart';
import 'package:votingmobile/voting/ui/multiple_choice_voting_results_box.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

import '../../make_testable_widget.dart';

void main() {
  testWidgets("MultipleChoiceVotingResultsBox should be displayed",
      (WidgetTester tester) async {
    final voting = Voting(
        id: 1,
        cardinality: VotingCardinality.MULTIPLE_CHOICE,
        majority: VotingMajority.ABSOLUTE,
        name: "whole voting name",
        secrecy: false,
        status: VotingStatus.FINISHED,
        options: [
          VotingOption(id: 1, name: "option1"),
          VotingOption(id: 2, name: "option2"),
        ],
        results: {
          1: VotingResults(
            optionId: 1,
            against: 10,
            hold: 10,
            inFavor: 10,
            wasSuccessful: false,
          ),
          2: VotingResults(
            optionId: 2,
            against: 10,
            hold: 10,
            inFavor: 10,
            wasSuccessful: false,
          ),
        });
    final Widget testableWidget =
        makeTestableWidgetWithActiveVoting(MultipleChoiceVotingResultsBox(
      voting: voting,
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    expect(find.text(voting.name), findsOneWidget);
    expect(find.text(voting.options.first.name), findsOneWidget);
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(typeOf<DotsIndicator<VotingOption>>()), findsOneWidget);
    expect(find.byType(VotingResultsBox), findsNWidgets(voting.options.length));
  });
}
