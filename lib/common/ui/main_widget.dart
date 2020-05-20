import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Container(
        child: SingleChildScrollView(
          child: Placeholder(
            fallbackHeight: 1500,
          ),
        ),
      ),
    );
  }
}
