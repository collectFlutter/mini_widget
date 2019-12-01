import 'dart:math';

import 'package:flutter/material.dart';

import 'base_painter.dart';

/// 绘制弧线（默认是圆）
class ArcPainter extends BasePainter {
  /// 开始角度
  final double startAngle;

  /// 间隔角度
  final double sweepAngle;

  /// 默认是画圆
  ArcPainter(
      {this.startAngle = 0.0,
      this.sweepAngle = 360.0,
      Color color = Colors.blue,
      double strokeWidth = 1})
      : super(color: color, strokeWidth: strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) * 0.5;
    Offset center = Offset(size.width * 0.5, size.height * 0.5);

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
        rect, startAngle * rad, sweepAngle * rad, false, customPaint);
  }
}
