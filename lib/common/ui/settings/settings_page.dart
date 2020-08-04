import 'package:flutter/material.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/common/ui/settings/rolling_switch.dart';
import 'package:votingmobile/common/utils/loading_blockade_util.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/localization/translations_delegate.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/main.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static const Map<bool, Locale> _valueToLocaleMap = {
    true: englishLocale,
    false: polishLocale
  };
  final userRepository = locator.get<UserRepository>();
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    return CommonRoute(
      title: translations.settings,
      child: Container(
        constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Divider(),
            _buildLocaleSettings(context),
            Divider(),
          ],
        ),
      ),
      bottomSection: userRepository.isLoggedIn
          ? CommonGradientButton(
              title: translations.logout,
              onPressed: () {
                applyBlockade(context, future: userRepository.logout(),
                    onFutureResolved: (_) {
                  navigateToHomePage(context);
                });
              },
            )
          : null,
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
