import 'package:flutter/material.dart';

class TabModel {
  String label;
  int? flex;
  TextStyle? textStyle;
  VoidCallback? onTop;
  double? width;
  EdgeInsetsGeometry? padding;
  AlignmentGeometry? alignment;
  Widget? child;
  bool showLeft;
  bool showRight;
  bool showBottom;
  bool showTooltip;

  TabModel({
    required this.label,
    this.flex,
    this.textStyle,
    this.onTop,
    this.width,
    this.child,
    this.padding = const EdgeInsets.all(3),
    this.alignment,
    this.showLeft = false,
    this.showRight = false,
    this.showBottom = false,
    this.showTooltip = true,
  });
}
