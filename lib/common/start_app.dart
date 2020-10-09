import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/home_page.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

void startApp(Config config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies(config);
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  runApp(
    ChangeNotifierProvider<ActiveVoting>(
      create: (context) => ActiveVoting(),
      child: HomePage(),
    ),
  );
}
