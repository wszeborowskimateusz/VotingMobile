import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/ui/settings/settings_page.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/ui/vote_sheet.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;
  final Widget rightIcon;
  final Widget leftIcon;
  final bool displayLeftBackIcon;
  final bool displayVoteSheet;

  const CommonLayout({
    @required this.body,
    this.rightIcon,
    this.leftIcon,
    this.displayLeftBackIcon = true,
    this.displayVoteSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveVoting>(
      builder: (context, activeVotingModel, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: leftIcon ??
              (displayLeftBackIcon
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.black,
                    )
                  : null),
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
        body: SafeArea(child: body),
        bottomSheet: !displayVoteSheet
            ? null
            : activeVotingModel.activeVoting != null
                ? VoteSheet(body: body)
                : NoActiveVotingSheet(),
      ),
    );
  }
}
