import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

import '../bean/a.dart';

buildEditCell({
  EdgeInsetsGeometry padding = const EdgeInsets.all(1),
  double minHeight = 35,
  EditValueModel data,
}) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: padding,
          color: data.color,
          child: data.tag2 == null
              ? _buildOneItem(
                  hintText: data.hintText,
                  valueColor: data.valueColor,
                  tagWidth: data.tagWidth,
                  isEdit: data.isEdit,
                  required: data.required,
                  tag: data.tag,
                  tagColor: data.tagColor,
                  suffix: data.suffix,
                  controller: data.controller,
                  inputType: data.inputType,
                  child: data.child,
                  valueMaxLines: data.maxLines,
                  minHeight: minHeight,
                )
              : _buildTwoItem(
                  suffix: data.suffix,
                  suffix2: data.suffix2,
                  valueMaxLines: data.maxLines,
                  valueColor: data.valueColor,
                  valueColor2: data.valueColor2,
                  tagWidth: data.tagWidth,
                  tagWidth2: data.tagWidth2,
                  isEdit: data.isEdit,
                  isEdit2: data.isEdit2,
                  required: data.required,
                  required2: data.required2,
                  tag: data.tag,
                  tag2: data.tag2,
                  tagColor: data.tagColor,
                  tagColor2: data.tagColor2,
                  controller: data.controller,
                  controller2: data.controller2,
                  inputType: data.inputType,
                  inputType2: data.inputType2,
                  hintText: data.hintText,
                  hintText2: data.hintText2,
                  minHeight: minHeight,
                ),
        ),
        data.showLine
            ? Divider(height: 1, color: Colors.grey[80])
            : Container(height: 0),
      ],
    ),
  );
}

_buildTwoItem(
    {String tag,
    double tagWidth = 80,
    String tag2,
    double tagWidth2 = 80,
    double minHeight = 35,
    String suffix,
    String suffix2,
    Color tagColor = MiniColor.gray,
    Color tagColor2 = MiniColor.gray,
    Color valueColor = MiniColor.black,
    Color valueColor2 = MiniColor.black,
    FocusNode focusNode,
    FocusNode focusNode2,
    bool required = false,
    bool required2 = false,
    int valueMaxLines = 1,
    bool isEdit = true,
    bool isEdit2 = true,
    TextEditingController controller,
    TextEditingController controller2,
    ValueChanged<String> onChange,
    ValueChanged<String> onChange2,
    TextInputType inputType = TextInputType.text,
    TextInputType inputType2 = TextInputType.text,
    InputDecoration inputDecoration,
    InputDecoration inputDecoration2,
    String hintText,
    String hintText2}) {
  return Flex(direction: Axis.horizontal, children: <Widget>[
    Container(
      width: tagWidth,
      height: minHeight,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
                tag,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: tagColor, height: 1.1),
              ),
              flex: 1),
          required
              ? Icon(MdiIcons.multiplication, size: 8, color: Colors.red)
              : Container(),
        ],
      ),
    ),
    Expanded(
      flex: 1,
      child: TextField(
        maxLines: valueMaxLines,
        enabled: isEdit,
        focusNode: focusNode,
        enableInteractiveSelection: isEdit,
        controller: controller,
        maxLengthEnforced: true,
        onChanged: onChange,
        keyboardType: inputType,
        inputFormatters: _getInputFormatter(inputType),
        decoration: inputDecoration ??
            InputDecoration(
                hintText: hintText ?? '请填写$tag',
                hasFloatingPlaceholder: false,
                border: isEdit ? null : InputBorder.none,
                contentPadding: EdgeInsets.only(left: 3),
                suffixStyle: TextStyle(color: Colors.black87),
                suffixText: suffix ?? ''),
        style: TextStyle(height: 1.1, fontSize: 14, color: valueColor),
      ),
    ),
    Container(
      width: tagWidth2,
      height: minHeight,
      padding: EdgeInsets.only(left: 3),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
                tag2,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: tagColor2, height: 1.1),
              ),
              flex: 1),
          required2
              ? Icon(MdiIcons.multiplication, size: 8, color: Colors.red)
              : Container(),
        ],
      ),
    ),
    Expanded(
      flex: 1,
      child: TextField(
        maxLines: valueMaxLines,
        enabled: isEdit,
        focusNode: focusNode2,
        enableInteractiveSelection: isEdit,
        controller: controller2,
        maxLengthEnforced: true,
        onChanged: onChange2,
        keyboardType: inputType2 ?? TextInputType.text,
        inputFormatters: _getInputFormatter(inputType ?? TextInputType.text),
        decoration: inputDecoration2 ??
            InputDecoration(
              hintText: hintText2 ?? '请填写$tag2',
              hasFloatingPlaceholder: false,
              border: isEdit2 ? null : InputBorder.none,
              contentPadding: EdgeInsets.only(left: 3),
              suffixText: suffix2 ?? '',
              suffixStyle: TextStyle(color: Colors.black87),
            ),
        style: TextStyle(height: 1.1, fontSize: 14, color: valueColor2),
      ),
    ),
  ]);
}

_buildOneItem(
    {String tag,
    String suffix,
    double tagWidth = 80,
    double minHeight = 35,
    Color valueColor = MiniColor.black,
    Color tagColor = MiniColor.gray,
    bool required = false,
    int valueMaxLines = 1,
    bool isEdit = true,
    FocusNode focusNode,
    KeyboardActionsConfig config,
    TextEditingController controller,
    ValueChanged<String> onChange,
    TextInputType inputType = TextInputType.text,
    InputDecoration inputDecoration,
    String hintText,
    Widget child}) {
  return Row(
    children: <Widget>[
      Container(
        width: tagWidth,
        height: minHeight,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  tag,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: tagColor, height: 1.1),
                ),
                flex: 1),
            required
                ? Icon(MdiIcons.multiplication, size: 8, color: Colors.red)
                : Container(),
          ],
        ),
      ),
      Expanded(
        child: child ??
            TextField(
              maxLines: valueMaxLines,
              focusNode: focusNode,
              enabled: isEdit,
              enableInteractiveSelection: isEdit,
              maxLengthEnforced: true,
              controller: controller,
              onChanged: onChange,
              keyboardType: inputType,
              inputFormatters: _getInputFormatter(inputType),
              decoration: inputDecoration ??
                  InputDecoration(
                      hintText: hintText ?? '请填写$tag',
                      hasFloatingPlaceholder: false,
                      border: isEdit ? null : InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 3),
                      suffixText: suffix ?? ''),
              style: TextStyle(height: 1.1, fontSize: 14, color: valueColor),
            ),
      ),
    ],
  );
}

_getInputFormatter(TextInputType keyboardType) {
  if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
    return [UsNumberTextInputFormatter()];
  }
  if (keyboardType == TextInputType.number ||
      keyboardType == TextInputType.phone) {
    return [WhitelistingTextInputFormatter.digitsOnly];
  }
  return null;
}
