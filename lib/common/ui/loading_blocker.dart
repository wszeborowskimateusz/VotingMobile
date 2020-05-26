import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class LoadingBlocker extends StatefulWidget {
  @override
  _LoadingBlockerState createState() => _LoadingBlockerState();
}

class _LoadingBlockerState extends State<LoadingBlocker> {
  final int _numberOfDots = 3;
  final double _dotSize = 30.0;
  final Color _color = Colors.black;
  final double _spaceBetweenDots = 15.0;
  final EdgeInsets _loaderMargin = const EdgeInsets.all(15.0);

  @override
  Widget build(BuildContext context) {
    final listOfDots = List<Widget>(_numberOfDots);
    for (int i = 0; i < _numberOfDots; i++) {
      listOfDots[i] = _AnimatedDot(
          startingPhase: i / _numberOfDots, color: _color, dotSize: _dotSize);
    }

    return Container(
      width: _numberOfDots * _dotSize + (_numberOfDots - 1) * _spaceBetweenDots,
      margin: _loaderMargin,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: listOfDots,
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  final double startingPhase;
  final double dotSize;
  final Color color;

  const _AnimatedDot({Key key, this.startingPhase, this.dotSize, this.color})
      : super(key: key);

  @override
  __AnimatedDotState createState() => __AnimatedDotState();
}

class __AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  SequenceAnimation _sequenceAnimation;
  final String _colorTag = "Color";

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _playAnimation();

    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: ColorTween(
                begin: widget.color.withOpacity(0.3),
                end: widget.color.withOpacity(1)),
            from: const Duration(seconds: 0),
            to: const Duration(seconds: 1),
            tag: _colorTag)
        .animate(_controller);
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller.forward(from: widget.startingPhase);
      await _controller.repeat(reverse: true);
    } on TickerCanceled {
      // disposed
    }
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) => Center(
        child: Container(
          width: widget.dotSize,
          height: widget.dotSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _sequenceAnimation[_colorTag].value),
        ),
      ),
      animation: _controller,
    );
  }
}
