import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 自定义对话框
class CustomizeDialog extends Dialog {
  // final Widget? child;
  final bool barrierDismissible;

  const CustomizeDialog({
    super.key,
    super.child,
    this.barrierDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.black45,
      child: GestureDetector(
        onTap: barrierDismissible ? () => Navigator.pop(context) : null,
        child: Container(
          color: Colors.black45,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
