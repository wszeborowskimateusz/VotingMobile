import 'package:flutter/material.dart';
import 'package:votingmobile/localization/translations.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).title),
      ),
      body: Container(),
      endDrawer: Drawer(
        child: SafeArea(
                  child: Column(
            children: <Widget>[Text("Test"), RaisedButton(child: Text("Test"),onPressed: (){},)],
          ),
        ),

      ),
    );
  }
}
