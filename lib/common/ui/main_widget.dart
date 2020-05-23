import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/ui/votings_list_widget.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      displayLeftIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(top: 0.0),
        child: VotingsListWidget(locator.get<VotingsRepository>().getVotings()),
      ),
    );
  }
}
