import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/settings/locale_change_notifier.dart';
import 'package:votingmobile/common/settings/theme_change_notifier.dart';
import 'package:votingmobile/common/ui/main_widget.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleChangeNotifier>(
      builder: (_, localeNotifier, __) => Consumer<ThemeChangeNotifier>(
        builder: (___, themeNotifier, ____) => MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            locator.get<TranslationsDelegate>(),
          ],
          supportedLocales: supportedLocales,
          locale: localeNotifier.selectedLocale,
          title: 'MoPS',
          darkTheme: ThemeData.dark(),
          theme: ThemeData.light(),
          themeMode: themeNotifier.selectedTheme,
          home: MainWidget(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
