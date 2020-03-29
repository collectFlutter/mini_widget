import 'package:flutter/material.dart';

Widget buildInkCell({
  EdgeInsetsGeometry margin = const EdgeInsets.all(5),
  VoidCallback onTap,
  VoidCallback onLongPress,
  Color backColor = Colors.white,
  double borderRadiusSize = 3,
  Widget child,
}) {
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
