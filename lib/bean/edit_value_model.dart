import 'package:flutter/material.dart';

class EditValueModel{
  /// 背景颜色
  Color color;

  /// 标题
  String tag;

  /// 后缀
  String suffix;

  /// 标签宽度
  double tagWidth;

  /// 内容颜色
  Color valueColor;

  FocusNode focusNode;

  /// 提示文字
  String hintText;

  /// 输入类型
  TextInputType inputType;

  /// 最大行数
  int maxLines;

  /// 内容更改回调
  ValueChanged<String> onChange;

  /// 输入框
  InputDecoration inputDecoration;

  /// 控制器
  TextEditingController controller;
  String tag2;
  String suffix2;
  double tagWidth2;
  String hintText2;
  Color valueColor2;
  TextInputType inputType2;
  FocusNode focusNode2;
  ValueChanged<String> onChange2;
  InputDecoration inputDecoration2;
  TextEditingController controller2;
  bool required2;
  bool isEdit2;
  int maxLines2;

  /// 是否显示下划线
  bool showLine;

  /// 是否编辑
  bool isEdit;

  /// 是否必填
  bool required;

  /// 自定义内容
  Widget child;
  EditValueModel({
    this.tag,
    this.suffix,
    this.tagWidth = 80,
    this.hintText,
    this.color = Colors.white,
    this.valueColor,
    this.inputType = TextInputType.text,
    this.maxLines = 1,
    this.onChange,
    this.inputDecoration,
    this.controller,
    this.tag2,
    this.suffix2,
    this.tagWidth2 = 80,
    this.hintText2,
    this.valueColor2,
    this.inputType2 = TextInputType.text,
    this.onChange2,
    this.inputDecoration2,
    this.controller2,
    this.maxLines2 = 1,
    this.showLine = true,
    this.isEdit = true,
    this.isEdit2 = true,
    this.required = false,
    this.required2 = false,
    this.focusNode,
    this.focusNode2,
    this.child,
  });
}