import 'package:flutter/material.dart';
import 'package:mini_widget/res/a.dart';

/// 圆角背景控件
// ignore: must_be_immutable
class BorderWidget extends StatelessWidget {
  Color backColor;
  final String label;
  final double fontSize;
  final Color textColor;
  final BorderRadiusGeometry borderRadius;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry margin;
  final double width;
  final double height;

  BorderWidget(
      {this.backColor,
      this.width,
      this.height,
      @required this.label,
      this.fontSize = 8,
      this.textColor = Colors.white,
      this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
      this.margin = const EdgeInsets.only(),
      this.fontWeight = FontWeight.bold}) {
    if (textColor != Colors.white && backColor == null) {
      this.backColor = textColor.withAlpha(80);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
//        YeDialog.defaultDialog(context, label);
      },
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: EdgeInsets.only(left: 5, right: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backColor ?? MiniColor.green,
          borderRadius: borderRadius,
        ),
        child: Text(
          label ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: this.textColor,
              fontSize: fontSize,
              fontWeight: fontWeight),
        ),
      ),
    );
  }
}
