import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';

class CommonRoute extends StatelessWidget {
  final Widget child;
  final Widget bottomSection;
  final String title;
  final bool displayRightIcon;
  final bool withSmallerFontSize;
  final bool alignTitleCenter;

  const CommonRoute({
    @required this.title,
    this.bottomSection,
    @required this.child,
    this.displayRightIcon = false,
    this.withSmallerFontSize = false,
    this.alignTitleCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return CommonLayout(
      // null will get as a default - settings icon
      rightIcon: displayRightIcon ? null : Container(),
      body: _ExpandedWithScroll(
        topSection: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            title,
            style: (withSmallerFontSize ? theme.headline5 : theme.headline4)
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: alignTitleCenter ? TextAlign.center : TextAlign.left,
          ),
        ),
        expandedSection: child,
        bottomSection: bottomSection,
      ),
    );
  }
}

class _ExpandedWithScroll extends StatelessWidget {
  final Widget topSection;
  final Widget expandedSection;
  final Widget bottomSection;

  const _ExpandedWithScroll(
      {this.topSection, this.expandedSection, this.bottomSection});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraint.maxHeight, minWidth: constraint.maxWidth),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20.0).copyWith(top: 12),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (topSection != null) topSection,
                          if (expandedSection != null)
                            Expanded(child: expandedSection),
                        ],
                      ),
                    ),
                    if (bottomSection != null) bottomSection,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
