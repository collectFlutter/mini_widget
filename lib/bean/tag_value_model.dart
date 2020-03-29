
import 'package:flutter/material.dart';

class TagValueModel {
  String tag;
  String value;
  Color valueColor;
  TextInputType inputType;
  bool clip;
  String tag2;
  String value2;
  Color valueColor2;
  TextInputType inputType2;
  Widget child;
  bool showLine;
  int maxLines2;
  int maxLines;
  TagValueModel(
      {this.tag,
        this.showLine = false,
        this.value,
        this.valueColor,
        this.clip = false,
        this.tag2,
        this.value2,
        this.valueColor2,
        this.inputType = TextInputType.text,
        this.inputType2 = TextInputType.text,
        this.child,
        this.maxLines,
        this.maxLines2});
}