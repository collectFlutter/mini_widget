import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoadingDialog extends StatelessWidget {
  LoadingDialog({
    Key key,
    this.hintText = '正在处理...',
  }) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 120.0,
              width: 120.0,
              decoration: ShapeDecoration(
                  color: const Color(0xFF3A3A3A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Theme(
                    data: ThemeData(
                        cupertinoOverrideTheme:
                            CupertinoThemeData(brightness: Brightness.dark)),
                    child: const CupertinoActivityIndicator(radius: 14.0),
                  ),
                  SizedBox(height: 20),
                  Text(
                    hintText ?? '正在处理...',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showLoadingDialog(
  BuildContext context, {
  String hintText,
  bool barrierDismissible = false,
  Future<bool> Function() onWillPop,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => WillPopScope(
      onWillPop: () => onWillPop ?? Future.value(barrierDismissible),
      child: LoadingDialog(hintText: hintText),
    ),
  );
}
