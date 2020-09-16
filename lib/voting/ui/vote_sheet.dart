import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';
import 'package:votingmobile/voting/models/voting_cardinality.dart';
import 'package:votingmobile/voting/ui/vote_page_multiple_choices.dart';
import 'package:votingmobile/voting/ui/vote_page_single_choice.dart';

class VoteSheet extends StatefulWidget {
  final Widget body;

  const VoteSheet({@required this.body});

  @override
  _VoteSheetState createState() => _VoteSheetState();
}

class _VoteSheetState extends State<VoteSheet> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);

    return SlidingSheet(
      elevation: 8,
      cornerRadius: 16,
      closeOnBackButtonPressed: true,
      maxWidth: Config.maxElementInAppWidth,
      isBackdropInteractable: true,
      closeOnBackdropTap: true,
      listener: (state) {
        if (mounted) {
          setState(() {
            _isExpanded = state.isExpanded;
          });
        }
      },
      snapSpec: const SnapSpec(
        snap: true,
        snappings: [56, double.infinity],
        positioning: SnapPositioning.pixelOffset,
      ),
      body: Container(color: Colors.white, child: widget.body),
      builder: (context, state) {
        final activeVoting =
            Provider.of<ActiveVoting>(context, listen: false).activeVoting;
        if (activeVoting == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(translations.noActiveVotingDisclaimer),
          ));
          return Container();
        }

        return activeVoting.cardinality == VotingCardinality.SINGLE_CHOICE
            ? VotePageSingleChoice()
            : VotePageMultipleChoices();
      },
      headerBuilder: (context, state) => _Header(isExpanded: _isExpanded),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isExpanded;
  final String customTitle;

  const _Header({this.isExpanded, this.customTitle});

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    return GestureDetector(
      onTap: () => customTitle != null ? null : _onTap(context),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4169E1), Color(0xff20b2aa)],
          ),
        ),
        constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth),
        height: 56,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          customTitle ??
              (isExpanded
                  ? translations.activeVoting
                  : translations.goToVoting),
          textAlign: TextAlign.center,
          style: customTitle != null
              ? Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white)
              : Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final controller = SheetController.of(context);
    isExpanded ? controller.collapse() : controller.expand();
  }
}

class NoActiveVotingSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Header(
      customTitle: Translations.of(context).noCurrentActiveVotingDisclaimer,
      isExpanded: false,
    );
  }
}
