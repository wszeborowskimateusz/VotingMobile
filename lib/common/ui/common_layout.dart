import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/settings/settings_page.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final Widget rightIcon;
  final bool displayLeftIcon;

  const CommonLayout({
    @required this.body,
    this.rightIcon,
    this.displayLeftIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: displayLeftIcon
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                )
              : null,
          elevation: 0.0,
          actions: <Widget>[
            rightIcon ??
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingPage(),
                      ),
                    );
                  },
                  color: Color(0xff4169E1),
                )
          ],
        ),
        backgroundColor: Colors.white,
        body: body,
      ),
    );
  }
}
