import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/settings/language_change_notifier.dart';
import 'package:votingmobile/common/ui/home_page.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

void startApp(Config config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies(config);
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  HttpOverrides.global = new _IgnoreBadCertificate();
  runApp(
    ChangeNotifierProvider<LanguageChangeNotifier>(
      create: (_) => LanguageChangeNotifier(),
      child: ChangeNotifierProvider<ActiveVoting>(
        create: (_) => ActiveVoting(),
        child: HomePage(),
      ),
    ),
  );
}

class _IgnoreBadCertificate extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
