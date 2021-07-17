import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/radio_button/custom_radio_button.dart';
import 'package:votingmobile/common/ui/radio_button/radio_model.dart';

import '../../../make_testable_widget.dart';

void main() {
  testWidgets("CustomRadioGroupWidget should display radio buttons", (WidgetTester tester) async {
    final List<RadioModel<_TestRadioValue>> radioModels = [
      RadioModel(false, null, "test1", Colors.green, _TestRadioValue(1)),
      RadioModel(false, null, "test2", Colors.green, _TestRadioValue(2)),
      RadioModel(false, null, "test3", Colors.green, _TestRadioValue(3)),
    ];
    final Widget testableWidget = makeTestableWidget(CustomRadioGroupWidget(
      radioList: radioModels,
    ));

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    expect(
        find.byType(typeOf<RoundRadioItem<_TestRadioValue>>()), findsNWidgets(radioModels.length));
    for (var model in radioModels) {
      expect(find.text(model.displayText), findsOneWidget);
    }
  });
}

class _TestRadioValue {
  final int id;

  const _TestRadioValue(this.id);
}
