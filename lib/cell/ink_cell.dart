import 'package:flutter/material.dart';

class InkCell extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Color backColor;
  final double borderRadiusSize;
  final Widget child;

  const InkCell({
    Key key,
    this.margin = const EdgeInsets.all(5),
    this.onTap,
    this.onLongPress,
    this.backColor = Colors.white,
    this.borderRadiusSize = 3,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadiusSize),
        color: backColor,
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadiusSize),
            onTap: onTap,
            onLongPress: onLongPress,
            child: child,
          ),
        ),
      ),
    );
  }
}
