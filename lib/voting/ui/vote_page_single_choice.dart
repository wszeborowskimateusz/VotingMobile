import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_popup.dart';
import 'package:votingmobile/common/utils/loading_blockade_util.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/vote_type.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';
import 'package:votingmobile/voting/ui/voting_options.dart';

class VotePageSingleChoice extends StatefulWidget {
  @override
  _VotePageSingleChoiceState createState() => _VotePageSingleChoiceState();
}

class _VotePageSingleChoiceState extends State<VotePageSingleChoice> {
  final VotingsRepository votingsRepository = locator.get();

  VoteType _selectedSingleOption;

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
      bottomButtonOnPressed: () => _onVoteButtonPressed(context),
    );
  }

  void _onVoteButtonPressed(BuildContext context) {
    final translations = Translations.of(context);
    showConfirmPopup(
      context: context,
      title: _selectedSingleOption == null
          ? translations.emptyVote
          : translations.singleVoteInfo(
              translations.getTranslationForVoteType(_selectedSingleOption)),
      onConfirm: (innerContext) {
        final activeVoting = Provider.of<ActiveVoting>(context, listen: false);

        // Remove the dialog
        Navigator.pop(innerContext);

        if (activeVoting.activeVoting == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(translations.noActiveVotingDisclaimer),
          ));
          navigateToHomePage(context);
          return;
        }

        applyBlockade(
          context,
          future: activeVoting.vote([_selectedSingleOption]),
          onFutureResolved: (_) {
            navigateToHomePage(context);
          },
        );
      },
    );
  }

  void _onVoteOptionChanged(VoteType value) {
    setState(() {
      _selectedSingleOption = value;
    });
  }
}
