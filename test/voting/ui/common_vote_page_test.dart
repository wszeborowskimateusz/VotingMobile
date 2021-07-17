import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';

import '../../make_testable_widget.dart';

const Key _key = Key("some key");

void main() {
  testWidgets("Common vote page should be displayed", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(CommonVotePage(
      votingOptions: Container(key: _key),
      bottomButtonOnPressed: () {},
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    expect(find.byKey(_key), findsOneWidget);
    expect(find.byType(CommonGradientButton), findsOneWidget);
  });
}
