import 'package:flutter/material.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/common/ui/common_route.dart';
import 'package:votingmobile/common/ui/radio_button/custom_radio_button.dart';
import 'package:votingmobile/common/ui/radio_button/radio_model.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/voting.dart';

class VotePage extends StatefulWidget {
  final String inFavorTranslation;
  final String againstTranslation;
  final String holdTranslation;
  const VotePage({
    @required this.inFavorTranslation,
    @required this.againstTranslation,
    @required this.holdTranslation,
  });

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  List<RadioModel> incidentTypeList;

  @override
  void initState() {
    super.initState();
    // TODO: Swap assets path when icons are ready
    incidentTypeList = [
      RadioModel(false, "assets/images/successful.svg",
          widget.inFavorTranslation, Color(0xff00B000)),
      RadioModel(false, "assets/images/unsuccessful.svg",
          widget.againstTranslation, Color(0xffC00000)),
      RadioModel(false, "assets/images/hold.svg", widget.holdTranslation,
          Colors.blueAccent)
    ];
  }

  String _selectedValue;

  @override
  Widget build(BuildContext context) {
    final Voting activeVoting = locator.get<VotingsRepository>().activeVoting;
    return CommonRoute(
      withSmallerFontSize: true,
      displayRightIcon: true,
      alignTitleCenter: true,
      title: activeVoting.name,
      child: CustomRadioGroupWidget(
        onChanged: getvalue,
        radioList: incidentTypeList,
      ),
      bottomSection: CommonGradientButton(
          title: Translations.of(context).vote,
          onPressed: _selectedValue == null
              ? null
              : () => _onVoteButtonPressed(context)),
    );
  }

  void _onVoteButtonPressed(BuildContext context) {
    
  }

  void getvalue(String value) {
    setState(() {
      _selectedValue = value;
    });
  }
}
