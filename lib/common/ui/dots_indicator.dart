import 'package:flutter/material.dart';

class DotsIndicator<T> extends StatefulWidget {
  const DotsIndicator({
    Key key,
    @required this.options,
    @required int current,
  })  : _current = current,
        super(key: key);

  final List<T> options;
  final int _current;

  @override
  _DotsIndicatorState<T> createState() => _DotsIndicatorState<T>();
}

class _DotsIndicatorState<T> extends State<DotsIndicator<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.options.map((option) {
        final int index = widget.options.indexOf(option);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget._current == index
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.4),
          ),
        );
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
