import 'package:flutter/material.dart';
import '../painter/dash_board_painter.dart';

import 'base_widget.dart';

class BashBoardWidget extends BaseWidget {
  /// 直径
  final double diameter;

  BashBoardWidget(this.diameter, {Color color = Colors.blue, double strokeWidth = 1.0})
      : super(color: color, width: diameter, height: diameter, strokeWidth: strokeWidth);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(diameter, diameter),
      painter: DashBoardPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}
