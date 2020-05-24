import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_popup.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/vote_type.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';
import 'package:votingmobile/voting/ui/voting_options.dart';

class VotePageSingleChoice extends StatefulWidget {
  @override
  _VotePageSingleChoiceState createState() => _VotePageSingleChoiceState();
}

class _VotePageSingleChoiceState extends State<VotePageSingleChoice> {
  VoteType _selectedSingleOption;

  final Voting activeVoting = locator.get<VotingsRepository>().activeVoting;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    return CommonVotePage(
      votingOptions: VotingOptions(
        inFavorTranslation: translations.voteInFavor,
        againstTranslation: translations.voteAgainst,
        holdTranslation: translations.voteHold,
        onValueChanged: _onVoteOptionChanged,
      ),
      bottomButtonOnPressed: _selectedSingleOption == null
          ? null
          : () => _onVoteButtonPressed(context),
    );
  }

  void _onVoteButtonPressed(BuildContext context) {
    final translations = Translations.of(context);
    showConfirmPopup(
      context: context,
      title: translations.singleVoteInfo(
          translations.getTranslationForVoteType(_selectedSingleOption)),
      onConfirm: () {},
    );
  }

  void _onVoteOptionChanged(VoteType value) {
    setState(() {
      _selectedSingleOption = value;
    });
  }
}
