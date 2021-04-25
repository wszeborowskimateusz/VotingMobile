import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class RollingSwitch extends StatefulWidget {
  @required
  final bool value;
  @required
  final ValueChanged<bool> onChanged;
  final String textOff;
  final String textOn;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final String iconOnPath;
  final String iconOffPath;

  RollingSwitch({
    this.value = false,
    this.textOff = "Off",
    this.textOn = "On",
    this.textSize = 14.0,
    this.colorOn = Colors.green,
    this.colorOff = Colors.red,
    @required this.iconOffPath,
    @required this.iconOnPath,
    this.animationDuration = const Duration(milliseconds: 600),
    this.onChanged,
  });

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<RollingSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return Container(
      padding: EdgeInsets.all(5),
      width: 130,
      decoration: BoxDecoration(
          color: transitionColor, borderRadius: BorderRadius.circular(50)),
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(10 * value, 0), //original
            child: Opacity(
              opacity: (1 - value).clamp(0.0, 1.0),
              child: Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                height: 40,
                child: Text(
                  widget.textOff,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.textSize),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(10 * (1 - value), 0),
            child: Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Container(
                padding: EdgeInsets.only(left: 5),
                alignment: Alignment.centerLeft,
                height: 40,
                child: Text(
                  widget.textOn,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.textSize),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(80 * value, 0),
            child: Transform.rotate(
              angle: lerpDouble(0, 2 * pi, value),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Opacity(
                        opacity: (1 - value).clamp(0.0, 1.0),
                        child: Image.asset(
                          widget.iconOffPath,
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ),
                    Center(
                      child: Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: Image.asset(
                          widget.iconOnPath,
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}
