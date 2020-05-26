import 'package:flutter/material.dart';
import 'package:votingmobile/common/utils/loading_blockade_util.dart'
    as blockade_util;

class CommonWillPopScope extends StatelessWidget {
  final Widget child;

  const CommonWillPopScope({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !blockade_util.isBlockade;
      },
      child: child,
    );
  }
}
