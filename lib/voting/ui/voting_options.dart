import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/radio_button/custom_radio_button.dart';
import 'package:votingmobile/common/ui/radio_button/radio_model.dart';
import 'package:votingmobile/voting/models/vote_type.dart';

class VotingOptions extends StatefulWidget {
  final String inFavorTranslation;
  final String againstTranslation;
  final String holdTranslation;
  final ValueChanged<VoteType> onValueChanged;
  final String optionName;

  const VotingOptions({
    @required this.inFavorTranslation,
    @required this.againstTranslation,
    @required this.holdTranslation,
    @required this.onValueChanged,
    this.optionName,
  });

  @override
  _VotingOptionsState createState() => _VotingOptionsState();
}

class _VotingOptionsState extends State<VotingOptions>
    with AutomaticKeepAliveClientMixin {
  List<RadioModel<VoteType>> incidentTypeList;

  @override
  void initState() {
    super.initState();
    incidentTypeList = [
      RadioModel<VoteType>(
        false,
        "assets/images/successful.png",
        widget.inFavorTranslation,
        Color(0xff00B000),
        VoteType.FOR,
      ),
      RadioModel<VoteType>(
        false,
        "assets/images/unsuccessful.png",
        widget.againstTranslation,
        Color(0xffC00000),
        VoteType.AGAINST,
      ),
      RadioModel<VoteType>(
        false,
        "assets/images/hold.png",
        widget.holdTranslation,
        Colors.blueAccent,
        VoteType.HOLD,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.optionName != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.optionName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        CustomRadioGroupWidget<VoteType>(
          onChanged: widget.onValueChanged,
          radioList: incidentTypeList,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
