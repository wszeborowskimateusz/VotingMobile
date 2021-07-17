import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/voting/models/voting_results.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';

import '../../make_testable_widget.dart';

void main() {
  testWidgets("VotingResultsBox should be displayed", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VotingResultsBox(
        votingName: "some voting",
        votingResults: VotingResults(against: 1, hold: 2, inFavor: 3, wasSuccessful: true),
      ),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.text("some voting"), findsOneWidget);
    expect(find.text("1"), findsOneWidget);
    expect(find.text("2"), findsOneWidget);
    expect(find.text("3"), findsOneWidget);
  });
}
