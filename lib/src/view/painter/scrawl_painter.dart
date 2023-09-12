import 'dart:ui';

import 'package:flutter/material.dart';

/// 涂鸦工具
class ScrawlPainter extends CustomPainter {
  final List<PaintModel> paints;

  ScrawlPainter({required this.paints});

  @override
  void paint(Canvas canvas, Size size) {
    if (paints.isEmpty) return;
    for (var paint in paints) {
      List<Offset> point = paint.sPoint;
      if (point.isEmpty) continue;
      if (point.length == 1) {
        canvas.drawPoints(PointMode.points, point, paint.linePaint);
      } else {
        for (var i = 0; i < point.length - 1; ++i) {
          canvas.drawLine(point[i], point[i + 1], paint.linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PaintModel {
  List<Offset> sPoint;
  Color strokeColor;
  double strokeWidth;
  late Paint linePaint;

  PaintModel({
    required this.sPoint,
    required this.strokeColor,
    this.strokeWidth = 1,
  }) {
    linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }
}
