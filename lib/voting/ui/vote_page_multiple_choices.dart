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
import 'package:votingmobile/voting/models/user_vote.dart';
import 'package:votingmobile/voting/models/user_votes.dart';
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
  List<UserVote> _selectedMultipleOptions;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _selectedMultipleOptions = Provider.of<ActiveVoting>(context, listen: false)
            .activeVoting
            ?.options
            ?.map((VotingOption option) =>
                UserVote(optionId: option.id, vote: VoteType.NO_VOTE))
            ?.toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveVoting>(
      builder: (context, activeVoting, child) =>
          activeVoting.activeVoting == null
              ? Center(child: CircularProgressIndicator())
              : CommonVotePage(
                  bottomButtonOnPressed: _onVoteButtonPressed,
                  votingOptions: Column(
                    children: <Widget>[
                      buildCarouselSlider(activeVoting, context),
                      Text(
                        "${_current + 1} / ${activeVoting.activeVoting.options.length}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      DotsIndicator<VotingOption>(
                        options: activeVoting.activeVoting.options,
                        current: _current,
                        dotSize: MediaQuery.of(context).size.width > 600
                            ? 30.0
                            : 12.0,
                      ),
                    ],
                  ),
                ),
    );
  }

  CarouselSlider buildCarouselSlider(
      ActiveVoting activeVoting, BuildContext context) {
    final translations = Translations.of(context);
    return CarouselSlider.builder(
      itemCount: activeVoting.activeVoting.options.length,
      itemBuilder: (context, index) {
        final VotingOption option = activeVoting.activeVoting.options[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: VotingOptions(
            inFavorTranslation: translations.voteInFavor,
            againstTranslation: translations.voteAgainst,
            holdTranslation: translations.voteHold,
            onValueChanged: (value) =>
                getValueForMultipleSelection(index, value, option.id),
            optionName: option.name,
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 2,
        initialPage: 0,
        autoPlay: false,
        pageViewKey: PageStorageKey(activeVoting.activeVoting.id),
        enableInfiniteScroll: false,
        enlargeCenterPage: false,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  void getValueForMultipleSelection(int index, VoteType value, int optionId) {
    setState(() {
      _selectedMultipleOptions[index] =
          UserVote(optionId: optionId, vote: value ?? VoteType.NO_VOTE);
    });
  }

  int get _getVottedAmount =>
      _selectedMultipleOptions.where((x) => x.vote != VoteType.NO_VOTE).length;

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
            future:
                activeVoting.vote(UserVotes(votes: _selectedMultipleOptions)),
            onFutureResolved: (_) {
          navigateToHomePage(context);
        });
      },
    );
  }
}
