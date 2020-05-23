import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translations.dart';

class VoteButton extends StatelessWidget {
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(8.0));

  @override
  Widget build(BuildContext context) {
    //TODO: Handle situation when we have active voting and user has alreade voted in it
    return RaisedButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {},
      elevation: 15.0,
      shape: RoundedRectangleBorder(
        borderRadius: _borderRadius,
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff4169E1), Color(0xff20b2aa)]),
          borderRadius: _borderRadius,
        ),
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width - 32.0,
          alignment: Alignment.center,
          child: Text(
            Translations.of(context).vote,
            style: Theme.of(context).primaryTextTheme.button.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
