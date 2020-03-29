import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

String getDateStr(String time) {
  if (time == null) return '';
  if (time.length > 10) return time.substring(0, 10).replaceAll("/", "-");
  return time;
}

String getTimeStr(String time) {
  if (time == null) return '';
  if (time.length > 16) return time.substring(11, 16);
  return time;
}

/// 简单提示
void toast(String msg) => showToast(msg);

/// 创建搜索内容
Widget buildSearchSpan(String content, String searchText,
    {Color searchTextColor = Colors.pink, TextStyle style = const TextStyle(color: Colors.black)}) {
  assert(searchText != null && content !=null);

  int startIndex = content.indexOf(searchText);

  int endIndex = -1;
  if (startIndex > -1) {
    endIndex = startIndex + searchText.length;
    return RichText(
        text: TextSpan(text: content.substring(0, startIndex), style: style, children: [
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