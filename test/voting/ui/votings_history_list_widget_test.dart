import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/models/voting_majority.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/models/voting_results.dart';
import 'package:votingmobile/voting/models/voting_status.dart';
import 'package:votingmobile/voting/ui/multiple_choice_voting_results_box.dart';
import 'package:votingmobile/voting/ui/voting_results_box.dart';
import 'package:votingmobile/voting/ui/votings_history_list_widget.dart';

import '../../make_testable_widget.dart';

class VotingsRepositoryMock extends Mock implements VotingsRepository {}

void main() {
  final votingsRepository = VotingsRepositoryMock();
  setUpAll(() {
    locator.registerLazySingleton<VotingsRepository>(() => votingsRepository);
  });

  testWidgets("VotingsHistoryListWidget should be displayed",
      (WidgetTester tester) async {
    final votingsHistory = _getVotingsHistory();
    when(votingsRepository.getVotingsHistory())
        .thenAnswer((_) async => votingsHistory);
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VotingsHistoryListWidget(),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.byType(MultipleChoiceVotingResultsBox), findsOneWidget);
    expect(find.byType(VotingResultsBox), findsNWidgets(2));
    expect(find.text(testStrings.votingsHistory), findsOneWidget);
  });

  testWidgets(
      "VotingsHistoryListWidget should be displayed when there are no votings in history",
      (WidgetTester tester) async {
    when(votingsRepository.getVotingsHistory()).thenAnswer((_) async => []);
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VotingsHistoryListWidget(),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.byType(NoActiveVotingNoVotingsHistory), findsOneWidget);
    expect(find.byType(CommonLayout), findsOneWidget);
    expect(find.text(testStrings.votingsHistory), findsOneWidget);
  });
}

List<Voting> _getVotingsHistory() {
  return [
    Voting(
      id: 1,
      cardinality: VotingCardinality.MULTIPLE_CHOICE,
      majority: VotingMajority.ABSOLUTE,
      name: "whole voting name",
      secrecy: false,
      status: VotingStatus.FINISHED,
      options: [
        VotingOption(id: 1, name: "option1"),
      ],
      results: {
        1: VotingResults(
          optionId: 1,
          against: 10,
          hold: 10,
          inFavor: 10,
          wasSuccessful: false,
        ),
      },
    ),
    Voting(
      id: 2,
      cardinality: VotingCardinality.SINGLE_CHOICE,
      majority: VotingMajority.ABSOLUTE,
      name: "whole voting name 2",
      secrecy: false,
      status: VotingStatus.FINISHED,
      options: [
        VotingOption(id: 1, name: "option1"),
      ],
      results: VotingResults(
        optionId: 1,
        against: 10,
        hold: 10,
        inFavor: 10,
        wasSuccessful: false,
      ),
    ),
  ];
}
