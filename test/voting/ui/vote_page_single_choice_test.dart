import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';
import 'package:votingmobile/voting/ui/vote_page_single_choice.dart';

import '../../make_testable_widget.dart';

class VotingsRepositoryMock extends Mock implements VotingsRepository {}

void main() {
  setUpAll(() {
    locator.registerLazySingleton<VotingsRepository>(() => VotingsRepositoryMock());
  });

  testWidgets("VotePageSingleChoice should be displayed", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VotePageSingleChoice(),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.byType(CommonVotePage), findsOneWidget);
  });
}
