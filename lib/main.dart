import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/main_widget.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

void main() {
  registerDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(HomePage());
  });
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        locator.get<TranslationsDelegate>(),
      ],
      supportedLocales: supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        final bool isLocaleSupported = supportedLocales.any((supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode);

        final Locale pickedLocale = isLocaleSupported ? locale : defaultLocale;

        return pickedLocale;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
      home: Builder(builder: (context) => MainWidget()),
      debugShowCheckedModeBanner: false,
    );
  }
}
