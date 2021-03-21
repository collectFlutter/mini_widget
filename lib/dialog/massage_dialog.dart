import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../res/a.dart';
import '../tools.dart';

void showMassageDialog(BuildContext context, String content,
    {String title,
    String colorContent,
    String cancelText,
    onCancelPressed,
    String okText,
    VoidCallback onOkPressed,
    bool left = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text(title ?? "提示"),
      content: Container(
        alignment: left ? Alignment.centerLeft : Alignment.center,
        padding: EdgeInsets.only(top: 10),
        child: buildSearchSpan(content ?? '', colorContent ?? '',
            style: TextStyle(height: 1.5, color: Colors.black)),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text(
            cancelText ?? "取消",
          ),
          onPressed: () {
            Navigator.pop(context);
            if (onCancelPressed != null) onCancelPressed();
          },
        ),
        CupertinoButton(
          child: Text(okText ?? "确认",
              style: TextStyle(color: MiniColor.warnColor)),
          onPressed: () {
            Navigator.of(context).pop();
            if (onOkPressed != null) onOkPressed();
          },
        )
      ],
    ),
  );
}
