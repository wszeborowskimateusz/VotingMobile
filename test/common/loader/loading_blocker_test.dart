import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/loader/loading_blocker.dart';

import '../../make_testable_widget.dart';

void main() {
  testWidgets("Loading blocker util should display animated dots", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidget(LoadingBlocker());

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byType(AnimatedDot), findsNWidgets(3));
  });
}