import 'package:flutter/material.dart';
import 'package:mini_widget/res/a.dart';

class TagValueModel {
  String tag;
  String value;
  Color valueColor;
  Color tagColor;
  TextInputType inputType;
  bool clip;
  String tag2;
  String value2;
  Color tagColor2;
  Color valueColor2;
  TextInputType inputType2;
  Widget child;
  bool showLine;
  int maxLines2;
  int maxLines;
  TagValueModel(
      {this.tag,
      this.tagColor = MiniColor.gray,
      this.showLine = false,
      this.value,
      this.valueColor = MiniColor.black,
      this.clip = false,
      this.tag2,
      this.tagColor2 = MiniColor.gray,
      this.value2,
      this.valueColor2 = MiniColor.black,
      this.inputType = TextInputType.text,
      this.inputType2 = TextInputType.text,
      this.child,
      this.maxLines,
      this.maxLines2});
}
