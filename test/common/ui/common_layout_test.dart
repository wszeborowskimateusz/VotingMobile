import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/models/voting_majority.dart';
import 'package:votingmobile/voting/models/voting_status.dart';
import 'package:votingmobile/voting/ui/vote_sheet.dart';

import '../../make_testable_widget.dart';

const Key _key = Key("gradient button");

void main() {
  testWidgets("Common layout should be displayed", (WidgetTester tester) async {
    final Widget testableWidget =
        makeTestableWidgetWithActiveVoting(CommonLayout(
      body: Container(key: _key),
      displayLeftBackIcon: true,
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byKey(_key), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets("Common layout should display custom icons",
      (WidgetTester tester) async {
    final Widget testableWidget =
        makeTestableWidgetWithActiveVoting(CommonLayout(
      body: Container(key: _key),
      leftIcon: Icon(Icons.ac_unit),
      rightIcon: Icon(Icons.ac_unit_outlined),
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byIcon(Icons.arrow_back), findsNothing);
    expect(find.byIcon(Icons.ac_unit), findsOneWidget);
    expect(find.byIcon(Icons.ac_unit_outlined), findsOneWidget);
  });

  testWidgets(
      "Common layout should display vote sheet when active voting is avaliable",
      (WidgetTester tester) async {
    final mockedActiveVoting = ActiveVotingMock();
    when(mockedActiveVoting.activeVoting).thenReturn(Voting(
      id: 1,
      name: "",
      status: VotingStatus.DURING_VOTING,
      cardinality: VotingCardinality.SINGLE_CHOICE,
      majority: VotingMajority.ABSOLUTE,
      secrecy: false,
      options: [],
    ));
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      CommonLayout(
        body: Container(key: _key),
        displayVoteSheet: true,
      ),
      mockedActiveVoting: mockedActiveVoting,
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byType(VoteSheet), findsOneWidget);
  });

  testWidgets(
      "Common layout should display no active vote sheet when no active voting is avaliable",
      (WidgetTester tester) async {
    final mockedActiveVoting = ActiveVotingMock();
    when(mockedActiveVoting.activeVoting).thenReturn(null);
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      CommonLayout(
        body: Container(key: _key),
        displayVoteSheet: true,
      ),
      mockedActiveVoting: mockedActiveVoting,
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byType(NoActiveVotingSheet), findsOneWidget);
  });
}
