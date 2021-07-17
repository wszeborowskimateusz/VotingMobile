import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/settings/rolling_switch.dart';

import '../../../make_testable_widget.dart';

const String _yesValue = "yes";
const String _noValue = "no";
const Key _key = Key("rolling switch");

void main() {
  testWidgets("RollingSwitch should be displayed", (WidgetTester tester) async {
    bool switchValue = true;
    final Widget testableWidget = makeTestableWidget(
      RollingSwitch(
        key: _key,
        value: switchValue,
        onChanged: (value) {
          switchValue = value;
        },
        textOn: _yesValue,
        textOff: _noValue,
        iconOnPath: "assets/images/pl.png",
        iconOffPath: "assets/images/pl.png",
      ),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    final opacity1 = find.byWidgetPredicate((w) => w is Opacity && w.opacity == 1.0);

    final yesValueFInder = find.descendant(of: opacity1, matching: find.text(_yesValue));
    final noValueFInder = find.descendant(of: opacity1, matching: find.text(_noValue));

    expect(yesValueFInder, findsOneWidget);
    expect(noValueFInder, findsNothing);

    await tester.tap(find.text(_yesValue));
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(switchValue, false);
  });
}
