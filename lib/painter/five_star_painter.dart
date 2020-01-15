import 'dart:math';

import 'package:flutter/material.dart';

import 'base_painter.dart';

/// 绘制五角星
class FiveStarPainter extends BasePainter {
  FiveStarPainter(
      {Color color = Colors.red,
      double rotateAngle = 0.0,
      double strokeWidth = 1.0})
      : super(color: color, rotateAngle: rotateAngle, strokeWidth: strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) * 0.5;
    // 计算五角星五个角坐标
    Offset p1 = Offset(radius, 0);
    Offset p2 = Offset(
        radius + radius * sin(pi * 0.4), radius - radius * cos(pi * 0.4));
    Offset p3 = Offset(
        radius + radius * sin(pi * 0.2), radius + radius * cos(pi * 0.2));
    Offset p4 = Offset(
        radius - radius * sin(pi * 0.2), radius + radius * cos(pi * 0.2));
    Offset p5 = Offset(
        radius - radius * sin(pi * 0.4), radius - radius * cos(pi * 0.4));
    Path path = Path();
    path.moveTo(p1.dx, p1.dy);
    path.lineTo(p3.dx, p3.dy);
    path.lineTo(p5.dx, p5.dy);
    path.lineTo(p2.dx, p2.dy);
    path.lineTo(p4.dx, p4.dy);
    path.lineTo(p1.dx, p1.dy);
    // 保存画布当前状态
    canvas.save();
    // 旋转画布
    rotate(size.width, size.height, canvas);
    // 绘制五角星
    canvas.drawPath(path, customPaint..style = PaintingStyle.fill);
    // 恢复画布到上一个save状态
    canvas.restore();
  }
}
