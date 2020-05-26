import 'package:flutter/material.dart';
import 'package:votingmobile/main.dart';

void navigateToHomePage(BuildContext context, {bool clearHistory = true}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => HomePage(), settings: RouteSettings()),
    (_) => !clearHistory,
  );
}
