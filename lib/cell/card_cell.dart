import 'package:flutter/material.dart';

//
class ColorCard extends StatelessWidget {
  ColorCard({Key key, @required this.child, this.lightColor, this.darkColor = const Color(0xFF4EE07A)})
      : super(key: key);

  final Widget child;

  /// 浅色
  final Color lightColor;

  /// 深色
  final Color darkColor;
  @override
  Widget build(BuildContext context) {
    Color lColor = lightColor;
    if (lColor == null) {
      lColor = darkColor.withAlpha(110);
    }
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(color: lColor, offset: Offset(2.0, 2.0), blurRadius: 8.0, spreadRadius: 0.0),
          ],
          gradient: LinearGradient(colors: [ darkColor,lColor,])),
      child: child,
    );
  }
}
