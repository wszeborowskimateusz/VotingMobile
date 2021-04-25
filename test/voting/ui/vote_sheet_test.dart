import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/ui/vote_sheet.dart';

import '../../make_testable_widget.dart';

class VotingsRepositoryMock extends Mock implements VotingsRepository {}

const Key _key = Key("some key");

void main() {
  setUpAll(() {
    locator.registerLazySingleton<VotingsRepository>(
        () => VotingsRepositoryMock());
  });

  testWidgets("VoteSheet should be displayed", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VoteSheet(body: Container(key: _key)),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.byKey(_key), findsOneWidget);
    expect(find.byType(SlidingSheet), findsOneWidget);
  });
}
