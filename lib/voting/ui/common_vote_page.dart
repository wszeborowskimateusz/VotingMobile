import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

class CommonVotePage extends StatelessWidget {
  final Widget votingOptions;
  final VoidCallback bottomButtonOnPressed;
  final String customVoteButton;

  const CommonVotePage({
    Key key,
    @required this.votingOptions,
    @required this.bottomButtonOnPressed,
    this.customVoteButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveVoting>(
      builder: (context, activeVoting, child) => Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              activeVoting.activeVoting?.name ?? "",
              style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          votingOptions,
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 16.0),
            child: CommonGradientButton(
              title: customVoteButton ?? Translations.of(context).vote,
              onPressed: bottomButtonOnPressed,
            ),
          ),
        ],
      ),
    );
  }
}
