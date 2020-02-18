import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_widget/painter/wave_progress_painter.dart';

class WaveProgress extends StatefulWidget {
  final double size;
  final Color borderColor, fillColor;
  final double progress;

  /// 显示标签
  final String label;

  /// 下部文字
  final String subLabel;

  WaveProgress(
    this.size,
    this.progress, {
    this.borderColor = Colors.blueAccent,
    this.fillColor = Colors.blueAccent,
    this.label,
    this.subLabel,
  });

  @override
  WaveProgressState createState() => WaveProgressState();
}

class WaveProgressState extends State<WaveProgress> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2500));
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CircleClipper(),
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: WaveProgressPainter(
          controller,
          widget.progress,
          label: widget.label,
          subLabel: widget.subLabel,
          borderColor: widget.borderColor,
          fillColor: widget.fillColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double r = min(size.width, size.height) * 0.5;
    return Path()..addOval(Rect.fromCircle(center: Offset(r, r), radius: r));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
