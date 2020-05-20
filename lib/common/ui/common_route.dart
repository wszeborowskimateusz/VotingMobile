import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';

class CommonRoute extends StatelessWidget {
  final Widget child;
  final String title;
  final bool displayRightIcon;

  const CommonRoute({
    @required this.title,
    @required this.child,
    this.displayRightIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      // null will get as a default - settings icon
      rightIcon: displayRightIcon ? null : Container(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
