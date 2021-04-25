import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/ui/radio_button/custom_radio_button.dart';
import 'package:votingmobile/voting/models/vote_type.dart';
import 'package:votingmobile/voting/ui/voting_options.dart';

import '../../make_testable_widget.dart';

void main() {
  testWidgets("VotingOptions should be displayed", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidgetWithActiveVoting(
      VotingOptions(
        againstTranslation: "",
        holdTranslation: "",
        inFavorTranslation: "",
        optionName: "option",
        onValueChanged: (_) {},
      ),
    );

    await tester.pumpWidget(testableWidget);
    await tester.pump(Duration(seconds: 3));

    expect(find.byType(typeOf<CustomRadioGroupWidget<VoteType>>()),
        findsOneWidget);
    expect(find.text("option"), findsOneWidget);
  });
}
