import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings_en.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/localization/translations_delegate.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

final testStrings = TranslationStringsEn();

class ActiveVotingMock extends Mock implements ActiveVoting {}

Widget makeTestableWidgetWithActiveVoting(Widget widget,
    {ActiveVoting mockedActiveVoting}) {
  return makeTestableWidget(
    ChangeNotifierProvider<ActiveVoting>(
      create: (context) => mockedActiveVoting ?? ActiveVotingMock(),
      child: Builder(builder: (_) => widget),
    ),
  );
}

Widget makeTestableWidget(Widget widget) {
  locator.allowReassignment = true;
  locator.registerSingleton<Translations>(testStrings);
  locator.allowReassignment = false;

  return MaterialApp(
    home: widget,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      TranslationsDelegate(),
    ],
    supportedLocales: supportedLocales,
    locale: defaultLocale,
  );
}

Type typeOf<T>() => T;