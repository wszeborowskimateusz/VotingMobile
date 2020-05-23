import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';

class CommonRoute extends StatelessWidget {
  final Widget child;
  final String title;
  final bool displayRightIcon;
  final bool withSmallerFontSize;

  const CommonRoute({
    @required this.title,
    @required this.child,
    this.displayRightIcon = false,
    this.withSmallerFontSize = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return CommonLayout(
      // null will get as a default - settings icon
      rightIcon: displayRightIcon ? null : Container(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                title,
                style: (withSmallerFontSize ? theme.headline5 : theme.headline4)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
