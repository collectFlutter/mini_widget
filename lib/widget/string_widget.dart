import 'package:flutter/material.dart';
import 'package:mini_widget/painter/string_painter.dart';
import 'package:mini_widget/widget/base_widget.dart';

import '../mini_widget.dart';

class StringWidget extends BaseWidget {
  final String text;
  final double fontSize;

  /// 旋转角度
  final double rotateAngle;

  /// 上下对齐方式
  final VerticalAlign verticalAlign;

  /// 水平对齐方式
  final TextAlign horizontalTextAlign;

  /// [rotateAngle] - 居中旋转
  StringWidget(this.text,
      {this.verticalAlign = VerticalAlign.center,
      this.horizontalTextAlign = TextAlign.center,
      this.fontSize = 12,
      this.rotateAngle = 0.0,
      Color color = Colors.black,
      double width = 50,
      double height = 50})
      : super(color: color, width: width, height: height);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StringPainter(text,
          color: color,
          rotateAngle: rotateAngle,
          horizontalTextAlign: horizontalTextAlign,
          fontSize: fontSize,
          verticalTextAlign: verticalAlign),
      size: Size(width, height),
    );
  }
}
