import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static show(String msg,
      {duration = 2000,
      TextStyle? textStyle,
      Color? backgroundColor,
      bool dismissOtherToast = true}) {
    showToast(
      msg,
      textStyle: textStyle,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: dismissOtherToast,
      backgroundColor: backgroundColor,
    );
  }

  static showError(String msg) {
    num times = 2000;
    if (msg.length > 8) {
      times = 1000.0 * msg.length / 7;
    }
    showToast(
      msg,
      textStyle: const TextStyle(color: Colors.red),
      duration: Duration(milliseconds: times.toInt()),
      dismissOtherToast: true,
      backgroundColor: Colors.red[100],
    );
  }

  static cancelToast() {
    dismissAllToast();
  }
}
