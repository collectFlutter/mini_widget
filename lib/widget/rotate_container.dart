import 'package:flutter/material.dart';

/*
* 中心处旋转动画，AnimatedContainer针对的是左上角的旋转，注意角度传递的是π
* */
class RotateContainer extends StatefulWidget {
  final double endAngle; // 注意这个角度，π为180°
  final bool rotated;
  final Widget child;

  @override
  _RotateContainerState createState() => _RotateContainerState();

  RotateContainer({this.endAngle, this.child, this.rotated = false});
}

class _RotateContainerState extends State<RotateContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  double angle = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animation = Tween(begin: 0.0, end: widget.endAngle).animate(_controller)
      ..addListener(() {
        setState(() {
          angle = _animation.value;
        });
      });
    super.initState();
  }

  @override
  void didUpdateWidget(RotateContainer oldWidget) {
    if (oldWidget.rotated == widget.rotated) return; //防止多余刷新
    if (!widget.rotated) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: widget.child,
    );
  }
}
