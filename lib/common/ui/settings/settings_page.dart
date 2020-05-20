import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/localization/translations_delegate.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Locale pickedLocale;
  List<DropdownMenuItem<Locale>> localeDropdownMenus;
  @override
  void initState() {
    super.initState();
    localeDropdownMenus = supportedLocales
        .map((Locale locale) => DropdownMenuItem<Locale>(
              child: Text(locale.toLanguageTag()),
              value: locale,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CommonRoute(
      displayRightIcon: false,
      title: Translations.of(context).settings,
      child: Column(
        children: <Widget>[
          SearchableDropdown.single(
            displayClearIcon: false,
            items: localeDropdownMenus,
            value: pickedLocale ?? Translations.of(context).locale,
            hint: "Select one",
            searchHint: null,
            onChanged: (Locale value) {
              if (value != null) {
                setState(() {
                  locator.get<TranslationsDelegate>().load(value);
                  pickedLocale = value;
                });
              }
            },
            dialogBox: false,
            isExpanded: true,
            menuConstraints: BoxConstraints.tight(
              Size.fromHeight(350),
            ),
          )
        ],
      ),
    );
  }

  void showPickerDialog(BuildContext context) {}
}
