import 'package:flutter/material.dart';
import 'package:votingmobile/common/config/config.dart';

class CommonGradientButton extends StatelessWidget {
  static const BorderRadius _borderRadius =
      BorderRadius.all(Radius.circular(8.0));

  final VoidCallback onPressed;
  final String title;

  const CommonGradientButton({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth - 100),
        child: RaisedButton(
          padding: EdgeInsets.all(0.0),
          onPressed: onPressed,
          elevation: 15.0,
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius,
          ),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff4169E1), Color(0xff20b2aa)]),
              borderRadius: _borderRadius,
            ),
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width - 32.0,
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).primaryTextTheme.button.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
