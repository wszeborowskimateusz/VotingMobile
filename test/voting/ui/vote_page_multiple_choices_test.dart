import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/dots_indicator.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/models/voting_majority.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/models/voting_status.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';
import 'package:votingmobile/voting/ui/vote_page_multiple_choices.dart';

import '../../make_testable_widget.dart';

class VotingsRepositoryMock extends Mock implements VotingsRepository {}

void main() {
  setUpAll(() {
    locator.registerLazySingleton<VotingsRepository>(
        () => VotingsRepositoryMock());
  });

  testWidgets("VotePageMultipleChoices should be displayed",
      (WidgetTester tester) async {
    final voting = Voting(
      id: 1,
      cardinality: VotingCardinality.MULTIPLE_CHOICE,
      majority: VotingMajority.ABSOLUTE,
      name: "name",
      secrecy: false,
      status: VotingStatus.DURING_VOTING,
      options: [
        VotingOption(id: 1, name: "option1"),
        VotingOption(id: 2, name: "option2"),
      ],
    );
    final mockedActiveVoting = ActiveVotingMock();
    when(mockedActiveVoting.activeVoting).thenReturn(voting);
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VotePageMultipleChoices(),
      mockedActiveVoting: mockedActiveVoting,
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(CommonVotePage), findsOneWidget);
    expect(find.byType(typeOf<DotsIndicator<VotingOption>>()), findsOneWidget);
  }, skip: true /*TODO: This test throws overflow exception, make it work*/);
}
