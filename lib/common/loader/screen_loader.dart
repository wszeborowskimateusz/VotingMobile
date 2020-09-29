import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:votingmobile/common/loader/loading_blocker.dart';

mixin ScreenLoader<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;
  static const double _loadingBgBlur = 5.0;

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  /// DO NOT use this method in FutureBuilder because this methods
  /// updates the state which will make future builder to call
  /// this function again and it will go in loop
  Future<T> performFuture<T>(Function futureCallback) async {
    _startLoading();
    T data = await futureCallback().catchError((_) {});
    _stopLoading();
    return data;
  }

  Widget _loader() {
    return LoadingBlocker();
  }

  Widget _buildLoader() {
    if (_isLoading) {
      return Container(
        color: Colors.transparent,
        child: Center(
          child: _loader(),
        ),
      );
    }
    return Container();
  }

  Widget screen(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: Stack(
        children: <Widget>[
          screen(context),
          if (_isLoading)
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
}
