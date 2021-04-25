import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/main_widget.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void navigateToHomePage(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => MainWidget(), settings: RouteSettings()),
    (_) => false,
  );
}
