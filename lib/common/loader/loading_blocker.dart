import 'package:flutter/material.dart';

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
    final listOfDots = List.generate(
      _numberOfDots,
      (i) => AnimatedDot(
        startingPhase: i / _numberOfDots,
        color: _color,
        dotSize: _dotSize,
      ),
    );

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

@visibleForTesting
class AnimatedDot extends StatefulWidget {
  final double startingPhase;
  final double dotSize;
  final Color color;

  const AnimatedDot({Key key, this.startingPhase, this.dotSize, this.color})
      : super(key: key);

  @override
  _AnimatedDotState createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _playAnimation();

    _animation = ColorTween(
      begin: widget.color.withOpacity(0.3),
      end: widget.color.withOpacity(1),
    ).animate(_controller);
  }

  Future<Null> _playAnimation() async {
    try {
      if (mounted) {
        await _controller.forward(from: widget.startingPhase);
        if (mounted) {
          await _controller.repeat(reverse: true);
        }
      }
    } on TickerCanceled {
      // disposed
    }
  }

  @override
  void dispose() {
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
            color: _animation.value,
          ),
        ),
      ),
      animation: _controller,
    );
  }
}
