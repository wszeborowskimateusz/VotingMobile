import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/login/ui/login_page.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/ui/votings_history_list_widget.dart';

class MainWidget extends StatelessWidget {
  final VotingsRepository votingsRepository = locator.get<VotingsRepository>();

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      displayLeftIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(top: 0.0),
        child: locator.get<UserRepository>().isLoggedIn
            ? Consumer<ActiveVoting>(
                builder: (context, activeVoting, child) =>
                    VotingsHistoryListWidget(
                  historyVotings: votingsRepository.getVotingsHistory(),
                  activeVoting: activeVoting.activeVoting,
                ),
              )
            : LoginPage(),
      ),
    );
  }
}
