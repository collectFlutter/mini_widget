import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

void showInputDialog(BuildContext context, ValueChanged<String> okCallback,
    {String label,
    ValueChanged<String> cancelCallback,
    String content,
    String hintText,
    String title,
    String message,
    String cancelText,
    TextInputType inputType,
    String okText}) {
  TextEditingController _controller = TextEditingController(text: content);
  Widget contentWidget;
  if (message != null) {
    contentWidget = Container(
        constraints: BoxConstraints(maxHeight: 130),
        child: ListView(
          children: <Widget>[
            Text(message,
                textAlign: TextAlign.left,
                style: TextStyle(
                    height: 1.2,
                    color: Colors.pinkAccent,
                    fontSize: MiniDimen.fontNormal)),
            SingleChildScrollView(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  counterText: _controller.text,
                  labelText: label ?? "",
                  hintText: hintText ?? "请输入${label ?? ''}",
                ),
              ),
            ),
          ],
        ));
  } else {
    contentWidget = TextField(
        controller: _controller,
        keyboardType: inputType ?? TextInputType.text,
        inputFormatters: _getInputFormatter(inputType ?? TextInputType.text),
        decoration: InputDecoration(
          counterText: _controller.text,
          labelText: label,
          hintText: hintText ?? "请输入${label ?? ''}",
        ));
  }

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title ?? "提示"),
      content: contentWidget,
      actions: <Widget>[
        FlatButton(
          color: MiniColor.warnColor,
          child: Text(cancelText ?? "取消",
              style: TextStyle(color: MiniColor.white)),
          onPressed: () {
            if (cancelCallback != null) {
              cancelCallback(_controller.text);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        RaisedButton(
          child: Text(
            okText ?? "确认",
            style: TextStyle(color: MiniColor.white),
          ),
          onPressed: () {
            if (okCallback != null) {
              okCallback(_controller.text);
            } else {
              Navigator.of(context).pop();
            }
          },
        )
      ],
    ),
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
