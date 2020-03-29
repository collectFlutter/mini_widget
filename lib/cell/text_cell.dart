
import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/bean/tag_value_model.dart';
import 'package:mini_widget/res/a.dart';

/// Tag + Value（Child)
Widget buildTextCell(
    {TagValueModel data,
      Color color = Colors.white,
      double tagWidth = 70,
      double miniHeight = 20,
      double fontSize = 14,
      BuildContext context,
      EdgeInsetsGeometry padding = const EdgeInsets.all(1),
      double paddingRight = 0.0}) {
  fontSize = fontSize ?? MiniDimen.fontNormal;
  return Column(children: <Widget>[
    Padding(
      padding: padding,
      child: data.tag2 == null
          ? _buildOneLine(data.tag, data.value,
          color: data.valueColor,
          clip: data.clip,
          inputType: data.inputType,
          child: data.child,
          valueMaxLines: data.maxLines,
          tagWidth: tagWidth,
          miniHeight: miniHeight,
          fontSize: fontSize,
          context: context,
          paddingRight: paddingRight)
          : Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: _buildOneLine(data.tag, data.value,
                  color: data.valueColor,
                  clip: data.clip,
                  inputType: data.inputType,
                  valueMaxLines: data.maxLines,
                  tagWidth: tagWidth,
                  miniHeight: miniHeight,
                  fontSize: fontSize,
                  context: context,
                  paddingRight: paddingRight)),
          Expanded(
              flex: 1,
              child: _buildOneLine(data.tag2, data.value2,
                  color: data.valueColor2,
                  inputType: data.inputType2,
                  valueMaxLines: data.maxLines2,
                  tagWidth: tagWidth,
                  miniHeight: miniHeight,
                  clip: data.clip,
                  fontSize: fontSize,
                  context: context,
                  paddingRight: paddingRight)),
        ],
      ),
    ),
    data.showLine ? Divider() : Container(),
  ]);
}

_buildOneLine(String tag, String value,
    {Color color,
      TextInputType inputType = TextInputType.text,
      bool clip = false,
      Widget child,
      double tagWidth = 70,
      double miniHeight = 20,
      double fontSize,
      int valueMaxLines = 1,
      BuildContext context,
      double paddingRight = 0.0}) {
  bool flag = false;
  String url = '';
  if (inputType == TextInputType.phone) {
    flag = true;
    url = 'tel:$value';
  } else if (inputType == TextInputType.emailAddress) {
    flag = true;
    url = 'mailto:$value';
  } else if (inputType == TextInputType.url) {
    flag = true;
    url = value;
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: miniHeight),
      Container(
        alignment: Alignment.topLeft,
        width: tagWidth,
        child: Text(
          tag ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style:
          TextStyle(color: MiniColor.gray, height: 1.1, fontSize: fontSize),
        ),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: child ??
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        value ?? '',
                        overflow:
                        valueMaxLines == 1 ? TextOverflow.ellipsis : null,
                        maxLines: valueMaxLines,
                        style: TextStyle(
                            height: 1.1,
                            fontSize: fontSize,
                            color: color ??
                                (flag ? MiniColor.primary : MiniColor.black)),
                      ),
                    ),
                    clip ? Icon(Icons.content_copy, size: 12) : Container()
                  ],
                ),
                onTap: () {
                  if (flag) {
                    UrlUtil.launchUrl(url);
                  } else if (clip) {
                    if (!StringUtil.isEmpty(value) && context != null) {
                      StringUtil.clip(value);
//                      YU.toast('已复制');
                    }
                  }
                },
                onLongPress: () {
                  if (!StringUtil.isEmpty(value) && context != null && clip) {
                    StringUtil.clip(value);
//                    YU.toast('已复制');
                  }
                },
              ),
        ),
      ),
      SizedBox(width: paddingRight)
    ],
  );
}