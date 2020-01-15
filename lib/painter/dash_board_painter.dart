import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mini_widget/painter/base_painter.dart';

class DashBoardPainter extends BasePainter {
  /// 刻度值[0-1]
  final double value;

  /// 指标名称(最多4个字)
  final String label;
  final double angle = 24;
  TextPainter textPainter;

  DashBoardPainter({this.value = 0.6, Color color = Colors.blue, double strokeWidth = 1, this.label = '指标名称'})
      : super(color: color, strokeWidth: strokeWidth) {
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) * 0.5 - strokeWidth;
    final scale = radius / 75;
    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    customPaint.color = Colors.grey;
    canvas.drawArc(rect, 150 * rad, 240 * rad, false, customPaint);
    customPaint.color = color;
    canvas.drawArc(rect, 150 * rad, 240 * value * rad, false, customPaint);
    canvas.save();
    // 变换坐标原点
    canvas.translate(center.dx, center.dy);
    // 绘制圆心
    final centerPaint = Paint()
      ..strokeWidth = 2 * scale
      ..style = PaintingStyle.stroke
      ..color = color;
    canvas.drawCircle(Offset(0, 0), 4 * scale, centerPaint);
    canvas.save();
    // 绘制指针
    final secondPaint = Paint()
      ..color = color
      ..strokeWidth = 2 * scale;
    Offset endPoint = Offset(
      (radius - strokeWidth - 20 * scale) * cos((150 + angle * value * 10) * rad),
      (radius - strokeWidth - 20 * scale) * sin((150 + angle * value * 10) * rad),
    );
    Offset startPoint = Offset(
      4 * scale * cos((150 + angle * value * 10) * rad),
      4 * scale * sin((150 + angle * value * 10) * rad),
    );
    canvas.drawLine(startPoint, endPoint, secondPaint);
    canvas.save();
    // 绘制刻度
    List.generate(11, (index) {
      canvas.save();
      textPainter.text = TextSpan(
        text: "$index",
        style: TextStyle(color: Colors.black, fontFamily: 'Times New Roman', fontSize: 12.0 * scale),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (radius - strokeWidth - 5 * scale) * cos((150 + angle * index) * rad) - (textPainter.width * 0.5),
          (radius - strokeWidth - 5 * scale) * sin((150 + angle * index) * rad) - (textPainter.height * 0.5),
        ),
      );
      final centerPaint = Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.fill
        ..color = index <= value * 10 ? Colors.blue : Colors.grey;
      canvas.drawCircle(
          Offset(
            (radius - strokeWidth * 0.5) * cos((150 + angle * index) * rad),
            (radius - strokeWidth * 0.5) * sin((150 + angle * index) * rad),
          ),
          1,
          centerPaint);
      canvas.restore();
    });
    canvas.save();

    // 绘制标题
    textPainter.text = TextSpan(
      text: label,
      style: TextStyle(color: Colors.grey, fontFamily: 'Times New Roman', fontSize: 14.0 * scale),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(0 - textPainter.width * 0.5, radius * 0.3 - textPainter.height * 0.5),
    );
    canvas.restore();
    canvas.save();
    // 绘制标题-百分比
    textPainter.text = TextSpan(
      text: "${value * 100}%",
      style: TextStyle(color: Colors.black, fontFamily: 'Times New Roman', fontSize: 22.0 * scale),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(0 - textPainter.width * 0.5, radius * 0.6 - textPainter.height * 0.5),
    );
    canvas.save();
    canvas.restore();
  }
}
