import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/common/ui/settings/rolling_switch.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          _buildLocaleSettings(context),
        ],
      ),
    );
  }

  Widget _buildLocaleSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Translations.of(context).language,
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: RollingSwitch(
            value: Translations.of(context).locale != englishLocale,
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
                setState(() {
                  locator
                      .get<TranslationsDelegate>()
                      .load(_valueToLocaleMap[state]);
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
