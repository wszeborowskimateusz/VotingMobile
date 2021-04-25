import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/login/ui/login_page.dart';

import '../../make_testable_widget.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

void main() {
  setUpAll(() {
    locator.registerLazySingleton<UserRepository>(() => UserRepositoryMock());
  });

  testWidgets("Login page should be displayed",
      (WidgetTester tester) async {

    final Widget testableWidget = makeTestableWidgetWithActiveVoting(LoginPage());

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    expect(find.byType(InputForm), findsOneWidget);
    expect(find.text(testStrings.login), findsNWidgets(2));
    expect(find.text(testStrings.loginDisclaimer), findsOneWidget);
  });
}
