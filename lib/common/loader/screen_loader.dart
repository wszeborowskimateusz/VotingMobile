import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:votingmobile/common/loader/loading_blocker.dart';

mixin ScreenLoader<T extends StatefulWidget> on State<T> {
  static const double _loadingBgBlur = 5.0;

  /// DO NOT use this method in FutureBuilder because this methods
  /// updates the state which will make future builder to call
  /// this function again and it will go in loop
  Future<T> performFuture<T>(Function futureCallback) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return _buildOnScreenLoader();
      },
    );
    T data = await futureCallback().catchError((_) {});
    Navigator.pop(context);
    print(data);
    return data;
  }

  Widget _loader() {
    return LoadingBlocker();
  }

  Widget _buildOnScreenLoader() {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: <Widget>[
          BackdropFilter(
            child: _buildLoader(),
            filter: ImageFilter.blur(
              sigmaX: _loadingBgBlur,
              sigmaY: _loadingBgBlur,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: _loader(),
      ),
    );
  }
}
