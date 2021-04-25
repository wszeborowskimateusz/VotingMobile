import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';

import '../../make_testable_widget.dart';

const String _buttonText = "some text";
const Key _key = Key("gradient button");

void main() {
  testWidgets("Common gradient button should be displayed",
      (WidgetTester tester) async {
    bool wasButtonPressed = false;
    final Widget testableWidget = makeTestableWidget(CommonGradientButton(
      key: _key,
      title: _buttonText,
      onPressed: () {
        wasButtonPressed = true;
      },
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text(_buttonText), findsOneWidget);

    await tester.tap(find.byKey(_key));

    expect(wasButtonPressed, true);
  });
}
