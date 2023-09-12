import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showConfirmDialog(BuildContext context, String content,
    {String? title,
    String? colorContent,
    String? cancelText,
    VoidCallback? onCancelPressed,
    String? okText,
    VoidCallback? onOkPressed,
    bool left = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text(title ?? "提示"),
      content: Container(
        alignment: left ? Alignment.centerLeft : Alignment.center,
        padding: const EdgeInsets.only(top: 10),
        child: buildSearchSpan(content, colorContent ?? '',
            style: TextStyle(
                height: 1.5,
                color: Theme.of(context).textTheme.bodyMedium?.color)),
      ),
      actions: <Widget>[
        CupertinoButton(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8)),
          onPressed: () {
            Navigator.pop(context);
            if (onCancelPressed != null) onCancelPressed();
          },
          child: Text(cancelText ?? "取消"),
        ),
        CupertinoButton(
          child:
              Text(okText ?? "确认", style: const TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.pop(context);
            if (onOkPressed != null) onOkPressed();
          },
        )
      ],
    ),
  );
}

void showMassageDialog(BuildContext context, String content,
    {String? title,
    String? colorContent,
    String? buttonText = '知道了',
    VoidCallback? onPressed,
    TextStyle? titleStyle,
    bool left = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text(title ?? "提示", style: titleStyle),
      content: GestureDetector(
        child: Container(
          alignment: left ? Alignment.centerLeft : Alignment.center,
          padding: const EdgeInsets.only(top: 10),
          child: buildSearchSpan(content, colorContent ?? '',
              style: const TextStyle(height: 1.5, color: Colors.black)),
        ),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text(buttonText ?? "知道了",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            } else {
              Navigator.pop(context);
            }
          },
        )
      ],
    ),
  );
}

/// 创建搜索内容
Widget buildSearchSpan(String content, String searchText,
    {Color searchTextColor = Colors.red,
    TextStyle style = const TextStyle(color: Colors.black)}) {
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
