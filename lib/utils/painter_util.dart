import 'dart:math';

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../mini_widget.dart';

/// TODO 待开发
class PainterUtil {
  // 1度对应的弧度
  static final double rad = pi / 180.0;

  static paintText(
      {@required Canvas canvas,
      @required Paint paint,
      @required String text,
      @required Size size,
      Offset center = const Offset(0.0, 0.0),
      TextAlign horizontalTextAlign,
      VerticalAlign verticalTextAlign,
      double fontSize = 12,
      Color color = Colors.black,
      double rotateAngle = 0.0,
      Offset rotateCanter = const Offset(0, 0)}) {
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: horizontalTextAlign,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
    ));
    pb.pushStyle(ui.TextStyle(color: color));
    pb.addText(text);
    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: size.width);
    //这里需要先layout, 后面才能获取到文字高度
    ui.Paragraph paragraph = pb.build()..layout(pc);
    //文字居中显示
    Offset offset = Offset(0.0, size.width * 0.5 - paragraph.height * 0.5);
    if (verticalTextAlign == VerticalAlign.top) {
      offset = Offset(0.0, 0.0);
    } else if (verticalTextAlign == VerticalAlign.bottom) {
      offset = Offset(0.0, size.width - paragraph.height);
    }
    rotate(
        canvas: canvas,
        center: rotateCanter,
        rotateAngle: rotateAngle,
        doPaint: () {
          canvas.drawParagraph(paragraph, offset);
        });
  }

  /// 绘制圆弧<br/>
  /// [canvas] - 画布 <br/>
  /// [radius] - 圆弧半径 <br/>
  /// [center] - 圆弧中心位置 <br/>
  /// [startAngle] - 圆弧开始角度 <br/>
  /// [sweepAngle] - 圆弧大小对应角度 <br/>
  /// [paint] - 画笔
  static paintArc({
    @required Canvas canvas,
    @required Paint paint,
    double radius = 50,
    Offset center = const Offset(0.0, 0.0),
    double startAngle = 0.0,
    double sweepAngle = 360.0,
  }) {
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle * rad, sweepAngle * rad, false, paint);
  }

  /// 按照指定中心平移
  static rotate(
      {@required Canvas canvas,
      Offset center = const Offset(.0, .0),
      double rotateAngle = 0,
      @required VoidCallback doPaint}) {
    if (doPaint == null) return;
    if (rotateAngle == 0 || center == Offset(.0, .0)) {
      // 执行绘画
      doPaint();
      return;
    }
    double rotate = rotateAngle * rad;
    // 先保存画布
    canvas.save();
    // 将画布中心平移到圆点
    canvas.translate(-center.dx, -center.dy);
    // 执行旋转
    canvas.rotate(rotate);
    // 执行绘画
    doPaint();
    // 恢复画布旋转
    canvas.rotate(-rotate);
    // 恢复平移前画布中心位置
    canvas.translate(center.dx, center.dy);
    // 恢复圆画布状态
    canvas.restore();
  }
}
