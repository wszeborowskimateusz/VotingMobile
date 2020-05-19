import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:votingmobile/common/ui/main_widget.dart';
import 'package:votingmobile/localization/translation_strings/translation_strings.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        TranslationsDelegate(),
      ],
      supportedLocales: supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        final bool isLocaleSupported = supportedLocales.any((supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode );

        final Locale pickedLocale = isLocaleSupported ? locale : defaultLocale;

        GetIt.instance.allowReassignment = true;
        GetIt.instance.registerLazySingleton<TranslationStrings>(
            () => getTranslationsForLocale(pickedLocale));
        GetIt.instance.allowReassignment = false;
        return pickedLocale;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWidget(),
    );
  }
}
