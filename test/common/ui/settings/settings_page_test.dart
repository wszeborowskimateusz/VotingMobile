import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/common/ui/settings/rolling_switch.dart';
import 'package:votingmobile/common/ui/settings/settings_page.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../make_testable_widget.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

class LocaleRepositoryMock extends Mock implements LocaleRepository {}

void main() {
  UserRepository userRepository = UserRepositoryMock();
  LocaleRepository localeRepository = LocaleRepositoryMock();

  setUpAll(() {
    locator.registerLazySingleton<UserRepository>(() => userRepository);
    locator.registerLazySingleton<LocaleRepository>(() => localeRepository);
  });

  testWidgets("Settings page should be displayed", (WidgetTester tester) async {
    when(userRepository.isLoggedIn).thenReturn(false);

    final Widget testableWidget = makeTestableWidgetWithActiveVoting(SettingsPage());

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    expect(find.byType(CommonRoute), findsOneWidget);
    expect(find.byType(RollingSwitch), findsOneWidget);
  });

  testWidgets("Settings should display logout button when user is logged in",
      (WidgetTester tester) async {
    when(userRepository.isLoggedIn).thenReturn(true);

    final Widget testableWidget = makeTestableWidgetWithActiveVoting(SettingsPage());

    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text(testStrings.logout), findsOneWidget);
  });
}
