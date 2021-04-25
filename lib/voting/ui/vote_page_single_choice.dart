import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/loader/screen_loader.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_popup.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/user_vote.dart';
import 'package:votingmobile/voting/models/user_votes.dart';
import 'package:votingmobile/voting/models/vote_type.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';
import 'package:votingmobile/voting/ui/voting_options.dart';

class VotePageSingleChoice extends StatefulWidget {
  @override
  _VotePageSingleChoiceState createState() => _VotePageSingleChoiceState();
}

class _VotePageSingleChoiceState extends State<VotePageSingleChoice>
    with ScreenLoader {
  VoteType _selectedSingleOption = VoteType.NO_VOTE;

  @override
  Widget screen(BuildContext context) {
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
      title: _selectedSingleOption == VoteType.NO_VOTE
          ? translations.emptyVote
          : translations.singleVoteInfo(
              translations.getTranslationForVoteType(_selectedSingleOption)),
      onConfirm: (innerContext) async {
        final activeVoting = Provider.of<ActiveVoting>(context, listen: false);

        // Remove the dialog
        Navigator.pop(innerContext);

        if (activeVoting.activeVoting == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(translations.noActiveVotingDisclaimer),
          ));
          navigateToHomePage(context);
          return;
        }

        await performFuture(() => activeVoting
            .vote(UserVotes(votes: [UserVote(vote: _selectedSingleOption)])));
        navigateToHomePage(context);
      },
    );
  }

  void _onVoteOptionChanged(VoteType value) {
    setState(() {
      _selectedSingleOption = value ?? VoteType.NO_VOTE;
    });
  }
}
