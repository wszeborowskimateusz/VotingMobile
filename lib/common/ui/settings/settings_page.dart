import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/loader/screen_loader.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/common/ui/home_page.dart';
import 'package:votingmobile/common/ui/settings/rolling_switch.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/localization/translations_delegate.dart';
import 'package:votingmobile/login/backend/user_repository.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with ScreenLoader {
  static const Map<bool, Locale> _valueToLocaleMap = {
    true: englishLocale,
    false: polishLocale
  };
  final userRepository = locator.get<UserRepository>();
  bool initialized = false;
  ShakeDetector _shakeDetector;
  bool _displayEasterEgg = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      _listenForShake();
    }
  }

  void _listenForShake() {
    _shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
      if (!_displayEasterEgg && mounted) {
        setState(() {
          _displayEasterEgg = true;
        });

        Future.delayed(Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _displayEasterEgg = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    super.dispose();
  }

  @override
  Widget screen(BuildContext context) {
    final translations = Translations.of(context);
    return CommonRoute(
      title: translations.settings,
      child: Container(
        constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Divider(),
                _buildLocaleSettings(context),
                Divider(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildEasterEgg(),
            ),
          ],
        ),
      ),
      bottomSection: userRepository.isLoggedIn
          ? CommonGradientButton(
              title: translations.logout,
              onPressed: () async {
                await performFuture(() => userRepository.logout());
                navigateToHomePage(context);
              },
            )
          : null,
    );
  }

  Widget _buildEasterEgg() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AnimatedOpacity(
        opacity: _displayEasterEgg ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("assets/images/easter_egg.jpg"),
        ),
      ),
    );
  }

  Widget _buildLocaleSettings(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          Translations.of(context).language,
          style: Theme.of(context).textTheme.headline5,
        ),
        RollingSwitch(
          value:
              locator.get<LocaleRepository>().selectedLocale == englishLocale,
          textOn: 'English',
          textOff: 'Polski',
          colorOn: Colors.blueAccent[700],
          colorOff: Colors.redAccent[700],
          iconOnPath: "assets/images/gb.png",
          iconOffPath: "assets/images/pl.png",
          textSize: 16.0,
          onChanged: (bool state) {
            if (!initialized) {
              initialized = true;
              // Skip initial change (due to animation)
            } else {
              onLocaleChanged(_valueToLocaleMap[state]);
            }
          },
        ),
      ],
    );
  }

  void onLocaleChanged(Locale newLocale) async {
    await locator.get<LocaleRepository>().setLocale(newLocale);
    HomePage.setLocale(context, newLocale);
  }
}
