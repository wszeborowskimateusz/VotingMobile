import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_popup.dart';
import 'package:votingmobile/common/ui/dots_indicator.dart';
import 'package:votingmobile/common/utils/loading_blockade_util.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/vote_type.dart';
import 'package:votingmobile/voting/models/voting_option.dart';
import 'package:votingmobile/voting/ui/common_vote_page.dart';
import 'package:votingmobile/voting/ui/voting_options.dart';

class VotePageMultipleChoices extends StatefulWidget {
  @override
  _VotePageMultipleChoicesState createState() =>
      _VotePageMultipleChoicesState();
}

class _VotePageMultipleChoicesState extends State<VotePageMultipleChoices> {
  final VotingsRepository votingsRepository = locator.get();
  List<VoteType> _selectedMultipleOptions;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _selectedMultipleOptions = List<VoteType>(
        Provider.of<ActiveVoting>(context, listen: false)
                .activeVoting
                ?.options
                ?.length ??
            0);
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    return Consumer<ActiveVoting>(
      builder: (context, activeVoting, child) =>
          activeVoting.activeVoting == null
              ? Center(child: CircularProgressIndicator())
              : CommonVotePage(
                  bottomButtonOnPressed:
                      _getVottedAmount == 0 ? null : _onVoteButtonPressed,
                  votingOptions: Column(
                    children: <Widget>[
                      CarouselSlider.builder(
                        itemCount: activeVoting.activeVoting.options.length,
                        itemBuilder: (context, index) {
                          final VotingOption option =
                              activeVoting.activeVoting.options[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: VotingOptions(
                              inFavorTranslation: translations.voteInFavor,
                              againstTranslation: translations.voteAgainst,
                              holdTranslation: translations.voteHold,
                              onValueChanged: (value) =>
                                  getValueForMultipleSelection(index, value),
                              optionName: option.name,
                            ),
                          );
                        },
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height / 2,
                            initialPage: 0,
                            autoPlay: false,
                            pageViewKey:
                                PageStorageKey(activeVoting.activeVoting.id),
                            enableInfiniteScroll: false,
                            enlargeCenterPage: false,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      DotsIndicator<VotingOption>(
                        options: activeVoting.activeVoting.options,
                        current: _current,
                        dotSize: 12.0,
                      ),
                    ],
                  ),
                ),
    );
  }

  void getValueForMultipleSelection(int index, VoteType value) {
    setState(() {
      _selectedMultipleOptions[index] = value;
    });
  }

  int get _getVottedAmount =>
      _selectedMultipleOptions.where((x) => x != null).length;

  void _onVoteButtonPressed() {
    final activeVoting = Provider.of<ActiveVoting>(context, listen: false);
    showConfirmPopup(
        context: context,
        title: Translations.of(context).multipleVoteInfo(
            _getVottedAmount, activeVoting.activeVoting.options.length),
        onConfirm: (innerContext) {
          // Remove the dialog
          Navigator.pop(innerContext);
          applyBlockade(context,
              future: activeVoting.vote(_selectedMultipleOptions),
              onFutureResolved: (_) {
            navigateToHomePage(context);
          });
        });
  }
}
