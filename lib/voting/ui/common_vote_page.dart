import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

class CommonVotePage extends StatelessWidget {
  final Widget votingOptions;
  final VoidCallback bottomButtonOnPressed;

  const CommonVotePage({
    Key key,
    @required this.votingOptions,
    @required this.bottomButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonRoute(
      withSmallerFontSize: true,
      displayRightIcon: true,
      alignTitleCenter: true,
      title: locator.get<VotingsRepository>().activeVoting.name,
      child: votingOptions,
      bottomSection: CommonGradientButton(
        title: Translations.of(context).vote,
        onPressed: bottomButtonOnPressed,
      ),
    );
  }
}
