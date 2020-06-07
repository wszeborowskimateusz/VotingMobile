import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/common_layout.dart';

class CommonRoute extends StatelessWidget {
  final Widget child;
  final Widget bottomSection;
  final String title;
  final bool displayRightIcon;
    final bool displayLeftIcon;
  final bool withSmallerFontSize;
  final bool alignTitleCenter;
  final bool removeContentHorizontalPadding;

  const CommonRoute({
    @required this.title,
    this.bottomSection,
    @required this.child,
    this.displayRightIcon = false,
    this.displayLeftIcon = true,
    this.withSmallerFontSize = false,
    this.alignTitleCenter = false,
    this.removeContentHorizontalPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final EdgeInsets padding = const EdgeInsets.all(20.0).copyWith(top: 12);
    return CommonLayout(
      // null will get as a default - settings icon
      rightIcon: displayRightIcon ? null : Container(),
      displayLeftIcon: displayLeftIcon,
      body: _ExpandedWithScroll(
        topSection: Padding(
          padding: padding,
          child: Text(
            title,
            style: (withSmallerFontSize ? theme.headline5 : theme.headline4)
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: alignTitleCenter ? TextAlign.center : TextAlign.left,
          ),
        ),
        expandedSection: Padding(
          padding: removeContentHorizontalPadding ? EdgeInsets.zero : padding,
          child: child,
        ),
        bottomSection: Padding(
          padding: padding,
          child: bottomSection,
        ),
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
        );
      },
    );
  }
}
