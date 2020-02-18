import 'package:flutter/material.dart';
import 'package:mini_widget/painter/wave_progress_painter.dart';

class WaveProgress extends StatefulWidget {
  final double size;
  final Color borderColor, fillColor;
  final double progress;

  WaveProgress(this.size, this.borderColor, this.fillColor, this.progress);

  @override
  WaveProgressState createState() => new WaveProgressState();
}

class WaveProgressState extends State<WaveProgress> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: widget.size,
        height: widget.size,
        child: ClipPath(
            clipper: CircleClipper(),
            child: new AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return new CustomPaint(painter: WaveProgressPainter(controller, widget.progress));
                })));
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(new Rect.fromCircle(center: new Offset(size.width / 2, size.height / 2), radius: size.width / 2));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
