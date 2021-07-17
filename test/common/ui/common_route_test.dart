import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/common/ui/common_route.dart';

import '../../make_testable_widget.dart';

const Key _key = Key("gradient button");
const String _routeTitle = "route title";

void main() {
  testWidgets("Common route should be displayed", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(CommonRoute(
      title: _routeTitle,
      child: Container(key: _key),
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byKey(_key), findsOneWidget);
    expect(find.text(_routeTitle), findsOneWidget);
    expect(find.byType(CommonLayout), findsOneWidget);
  });
}
