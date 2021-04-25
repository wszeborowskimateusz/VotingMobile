import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/dots_indicator.dart';

import '../../make_testable_widget.dart';

void main() {
  testWidgets("Dots indicator should be displayed",
      (WidgetTester tester) async {
    final Widget testableWidget =
        makeTestableWidgetWithActiveVoting(DotsIndicator(
      options: [1, 2, 3],
      current: 1,
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    final dotFinder = find.byWidgetPredicate(
        (w) => w is Container && w.decoration is BoxDecoration);

    expect(dotFinder, findsNWidgets(3));
  });
}
