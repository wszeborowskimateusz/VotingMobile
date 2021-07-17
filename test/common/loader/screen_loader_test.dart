import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/loader/loading_blocker.dart';
import 'package:votingmobile/common/loader/screen_loader.dart';

import '../../make_testable_widget.dart';

const Key _key = Key("some widget key");

void main() {
  testWidgets("Screen loader should be displayed properly", (WidgetTester tester) async {
    final Widget testableWidget = makeTestableWidget(_TestWidget());

    await tester.pumpWidget(testableWidget);
    await tester.pump();

    expect(find.byType(WillPopScope), findsNothing);
    expect(find.byKey(_key), findsOneWidget);

    final testButton = find.byType(TextButton);

    expect(testButton, findsOneWidget);

    await tester.tap(testButton);
    await tester.pump();

    expect(find.byType(LoadingBlocker), findsOneWidget);
    expect(find.byType(WillPopScope), findsOneWidget);

    await tester.pumpAndSettle();
  });
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> with ScreenLoader {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: _key,
      child: Container(),
      onPressed: () {
        performFuture(() async {
          await Future.delayed(Duration(seconds: 2));
        });
      },
    );
  }
}
