import 'package:flutter/material.dart';

//
Widget buildColorCard(
    {@required Widget child,
    Color lightColor,
    Color darkColor = const Color(0xFF4EE07A)}) {
  Color lColor = lightColor;
  if (lColor == null) {
    lColor = darkColor.withAlpha(110);
  }
  return DecoratedBox(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              color: lColor,
              offset: Offset(2.0, 2.0),
              blurRadius: 8.0,
              spreadRadius: 0.0),
        ],
        gradient: LinearGradient(colors: [
          darkColor,
          lColor,
        ])),
    child: child,
  );
}
