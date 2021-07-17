import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/login/ui/login_page.dart';
import 'package:votingmobile/voting/ui/votings_history_list_widget.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return locator.get<UserRepository>().isLoggedIn ? VotingsHistoryListWidget() : LoginPage();
  }
}
