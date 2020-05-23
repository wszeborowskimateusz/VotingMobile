import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/ui/vote_page.dart';

class VoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    //TODO: Handle situation when we have active voting and user has alreade voted in it
    return CommonGradientButton(
      title: Translations.of(context).vote,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VotePage(
              inFavorTranslation: translations.voteInFavor,
              againstTranslation: translations.voteAgainst,
              holdTranslation: translations.voteHold,
            ),
          ),
        );
      },
    );
  }
}
