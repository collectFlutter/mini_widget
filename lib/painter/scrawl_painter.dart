import 'dart:ui';

import 'package:flutter/material.dart';

/// 涂鸦工具
class ScrawlPainter extends CustomPainter {
  final List<PaintModel> paints;

  ScrawlPainter({@required this.paints});

  void paint(Canvas canvas, Size size) {
    if (paints == null || paints.length == 0) return;
    paints.forEach((paint) {
      List<Offset> point = paint.sPoint;
      if (point == null || point.length == 0) return;
      if (point.length == 1)
        canvas.drawPoints(PointMode.points, point, paint.linePaint);
      else {
        for (var i = 0; i < point.length - 1; ++i) {
          canvas.drawLine(point[i], point[i + 1], paint.linePaint);
        }
      }
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PaintModel {
  List<Offset> sPoint;
  Color strokeColor;
  double strokeWidth;
  Paint linePaint;
  PaintModel({this.sPoint, this.strokeColor, this.strokeWidth}) {
    linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }
}
