import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/loader/screen_loader.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_popup.dart';
import 'package:votingmobile/common/ui/dots_indicator.dart';
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
  _VotePageMultipleChoicesState createState() => _VotePageMultipleChoicesState();
}

enum _BottomVoteButton { Next, Vote }

class _VotePageMultipleChoicesState extends State<VotePageMultipleChoices> with ScreenLoader {
  final VotingsRepository votingsRepository = locator.get();
  final CarouselController _carouselController = CarouselController();
  List<UserVote> _selectedMultipleOptions;
  int _current = 0;
  _BottomVoteButton _bottomButtonOption = _BottomVoteButton.Next;
  bool _wasLastPageReached = false;

  @override
  void initState() {
    super.initState();
    _selectedMultipleOptions = Provider.of<ActiveVoting>(context, listen: false)
            .activeVoting
            ?.options
            ?.map((VotingOption option) => UserVote(optionId: option.id, vote: VoteType.NO_VOTE))
            ?.toList() ??
        [];
    if ([0, 1].contains(_selectedMultipleOptions.length)) {
      _bottomButtonOption = _BottomVoteButton.Vote;
      _wasLastPageReached = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveVoting>(
      builder: (context, activeVoting, child) => activeVoting.activeVoting == null
          ? Center(child: CircularProgressIndicator())
          : CommonVotePage(
              customVoteButton: _bottomButtonOption == _BottomVoteButton.Next
                  ? Translations.of(context).next
                  : Translations.of(context).vote,
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
                    dotSize: MediaQuery.of(context).size.width > 600 ? 30.0 : 12.0,
                    onDotTap: (index) {
                      _carouselController.animateToPage(index, duration: Duration(milliseconds: 500));
                    },
                  ),
                ],
              ),
            ),
    );
  }

  CarouselSlider buildCarouselSlider(ActiveVoting activeVoting, BuildContext context) {
    final translations = Translations.of(context);
    return CarouselSlider.builder(
      itemCount: activeVoting.activeVoting.options.length,
      carouselController: _carouselController,
      itemBuilder: (context, index, _) {
        final VotingOption option = activeVoting.activeVoting.options[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: VotingOptions(
            inFavorTranslation: translations.voteInFavor,
            againstTranslation: translations.voteAgainst,
            holdTranslation: translations.voteHold,
            onValueChanged: (value) => _onVoteValueChanged(index, value, option.id),
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
            if (index == activeVoting.activeVoting.options.length - 1) {
              _wasLastPageReached = true;
            }
            if (_wasLastPageReached) {
              _bottomButtonOption = _BottomVoteButton.Vote;
            }
          });
        },
      ),
    );
  }

  void _onVoteValueChanged(int index, VoteType value, int optionId) {
    setState(() {
      _selectedMultipleOptions[index] = UserVote(optionId: optionId, vote: value ?? VoteType.NO_VOTE);
    });
  }

  int get _getVottedAmount => _selectedMultipleOptions.where((x) => x.vote != VoteType.NO_VOTE).length;

  void _onVoteButtonPressed() {
    if (_bottomButtonOption == _BottomVoteButton.Next) {
      final int nextVoteIndex = _current + 1;
      if (nextVoteIndex < _selectedMultipleOptions.length) {
        _carouselController.animateToPage(nextVoteIndex, duration: Duration(milliseconds: 500));
      }
    } else {
      final activeVoting = Provider.of<ActiveVoting>(context, listen: false);
      showConfirmPopup(
        context: context,
        title: Translations.of(context).multipleVoteInfo(_getVottedAmount, activeVoting.activeVoting.options.length),
        onConfirm: (innerContext) async {
          // Remove the dialog
          Navigator.pop(innerContext);
          await performFuture(() => activeVoting.vote(UserVotes(votes: _selectedMultipleOptions)));
          navigateToHomePage(context);
        },
      );
    }
  }
}
