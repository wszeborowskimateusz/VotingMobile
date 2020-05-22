import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/localization/translations.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      displayLeftIcon: false,
      body: Container(
        child: SingleChildScrollView(
          child: Text(
            Translations.of(context).appTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
