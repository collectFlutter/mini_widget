import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mini_widget/painter/base_painter.dart';

class DashBoardPainter extends BasePainter {
  double value = 0.4;

  DashBoardPainter({Color color = Colors.blue, double strokeWidth = 1}) : super(color: color, strokeWidth: strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) * 0.5 - strokeWidth;
    Offset center = Offset(size.width * 0.5, size.height * 0.5);

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    customPaint.color = Colors.grey;
    canvas.drawArc(rect, 150 * rad, 240 * rad, false, customPaint);
    customPaint.color = color;
    canvas.drawArc(rect, 150 * rad, 240 * value * rad, false, customPaint);

    canvas.save();

    canvas.translate(center.dx, center.dy);

    List.generate(10, (index) {

    });

    canvas.drawLine(Offset(cos(30 * rad) * radius, sin(30 * rad) * radius),
        Offset(-cos(30 * rad) * radius, sin(30 * rad) * radius), customPaint);
  }
}
