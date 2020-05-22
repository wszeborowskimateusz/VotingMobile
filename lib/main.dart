import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/main_widget.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

   static void setLocale(BuildContext context, Locale newLocale) {
    _HomePageState state =
      context.findRootAncestorStateOfType<_HomePageState>();
    
    state.setState(() {
      state.selectedLocale = newLocale;
    });
  }
}

class _HomePageState extends State<HomePage> {
  Locale selectedLocale = locator.get<LocaleRepository>().selectedLocale;

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
      locale: selectedLocale,
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
