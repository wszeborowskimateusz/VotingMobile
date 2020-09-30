import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/main_widget.dart';

void navigateToHomePage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => MainWidget(), settings: RouteSettings()),
    (_) => false,
  );
}
