import 'package:flutter/material.dart';
import 'package:votingmobile/common/backend/locale_repository.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/common/ui/settings/rolling_switch.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/localization/translations_delegate.dart';
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

  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    return CommonRoute(
      displayRightIcon: false,
      title: Translations.of(context).settings,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(),
              _buildLocaleSettings(context),
              Divider(),
            ],
          ),
        ],
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
          iconOnPath: "assets/images/gb.svg",
          iconOffPath: "assets/images/pl.svg",
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
