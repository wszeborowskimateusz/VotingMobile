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

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with ScreenLoader {
  static const String _pug = "assets/images/pug.png";
  static const String _easterEgg = "assets/images/easter_egg.jpg";
  static const Duration _fadeDuration = Duration(milliseconds: 500);

  static const Map<bool, Locale> _valueToLocaleMap = {
    true: englishLocale,
    false: polishLocale
  };
  final userRepository = locator.get<UserRepository>();
  bool initialized = false;
  ShakeDetector _shakeDetector;
  bool _displayEasterEgg = false;
  String _easterEggImage = _pug;

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
            Future.delayed(_fadeDuration, () {
              if (mounted) {
                setState(() {
                  _easterEggImage = _pug;
                });
              }
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
  Widget build(BuildContext context) {
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
      child: GestureDetector(
        onDoubleTap: () {
          if (_displayEasterEgg) {
            setState(() {
              _easterEggImage = _easterEgg;
            });
          }
        },
        child: AnimatedOpacity(
          opacity: _displayEasterEgg ? 1.0 : 0.0,
          duration: _fadeDuration,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(_easterEggImage),
            backgroundColor: Colors.transparent,
          ),
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
