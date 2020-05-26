import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/voting.dart';
import 'package:votingmobile/voting/ui/vote_page_multiple_choices.dart';
import 'package:votingmobile/voting/ui/vote_page_single_choice.dart';

class VoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    //TODO: Handle situation when we have active voting and user has alreade voted in it
    return CommonGradientButton(
      title: translations.vote,
      onPressed: () {
        final activeVoting =
            Provider.of<ActiveVoting>(context, listen: false).activeVoting;
        if (activeVoting == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(translations.noActiveVotingDisclaimer),
          ));
          return;
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return activeVoting.cardinality == VotingCardinality.SINGLE_CHOICE
                  ? VotePageSingleChoice()
                  : VotePageMultipleChoices();
            },
          ),
        );
      },
    );
  }
}
