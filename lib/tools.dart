import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/// 简单提示
void showMessage(String msg, BuildContext context) =>
    showToast(msg, context: context);

/// 创建搜索内容
Widget buildSearchSpan(String content, String searchText,
    {Color searchTextColor = Colors.pink,
    TextStyle style = const TextStyle(color: Colors.black)}) {
  assert(searchText != null && content != null);

  int startIndex = content.indexOf(searchText);

  int endIndex = -1;
  if (startIndex > -1) {
    endIndex = startIndex + searchText.length;
    return RichText(
        text: TextSpan(
            text: content.substring(0, startIndex),
            style: style,
            children: [
          TextSpan(
              //获取剩下的字符串，并让它变成灰色
              text: searchText,
              style: style.copyWith(color: searchTextColor)),
          TextSpan(
              //获取剩下的字符串，并让它变成灰色
              text: content.substring(endIndex),
              style: style)
        ]));
  } else {
    return Text(content, maxLines: null, style: style);
  }
}
