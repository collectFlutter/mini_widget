import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/dialog/bottom_dialog.dart';
import 'package:mini_widget/dialog/input_dialog.dart';
import 'package:mini_widget/dialog/loading_dialog.dart';
import 'package:mini_widget/dialog/massage_dialog.dart';
import 'package:mini_widget/typedef.dart';
import 'package:mini_widget/util/navigator_util.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  List<TextEditingController> textControllers = [];
  bool _isShowDialog = false;

  @override
  initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(afterBuild);
  }

  /// 页面首次构建结束回调
  @protected
  void afterBuild(Duration timestamp) {}

  @override
  void dispose() {
    textControllers.forEach((_controller) {
      _controller?.dispose();
    });
    textControllers.clear();
    super.dispose();
  }

  void pop() => MiniNavigatorUtil.pop(context);

  @protected
  void back({@required bool success}) =>
      MiniNavigatorUtil.pop(context, success: success);

  @protected
  Future<dynamic> pushPage(Widget page) =>
      MiniNavigatorUtil.pushPage(context, page);

  /// 显示自定义对话框
  // Future showCustomDialog(Widget dialog, {bool barrierDismissible = true}) =>
  //     showCustomizeDialog(context, dialog, barrierDismissible: barrierDismissible);

  void showProgress([String hintText = '正在处理...']) {
    /// 避免重复弹出
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      showLoadingDialog(context, hintText: hintText, onWillPop: () async {
        _isShowDialog = false;
        return Future.value(true);
      });
    }
  }

  void closeProgress() {
    if (mounted && _isShowDialog && this.context != null) {
      _isShowDialog = false;
      MiniNavigatorUtil.pop(context);
    }
  }

  // void showToast(String string, {TextStyle textStyle}) =>
  //     ToastUtil.show(string, textStyle: textStyle);

  // void showError(String error) => ToastUtil.showError(error);

  void defaultDialog(String content,
          {String title,
          String colorContent,
          String okText = '知道了',
          String cancelText,
          VoidCallback onOkPressed,
          VoidCallback onCancelPressed,
          bool left = false}) =>
      showMassageDialog(
        context,
        content,
        title: title,
        colorContent: colorContent,
        // buttonText: buttonText,
        // onPressed: onPressed,
        cancelText: cancelText,
        okText: okText,
        onCancelPressed: onCancelPressed,
        onOkPressed: onOkPressed,
        left: left,
      );

  //
  // void confirmDialog(String content,
  //     {String title,
  //       String colorContent,
  //       String cancelText,
  //       onCancelPressed,
  //       String okText,
  //       VoidCallback onOkPressed,
  //       bool left = false}) =>
  //     showConfirmDialog(
  //       context,
  //       content,
  //       title: title,
  //       colorContent: colorContent,
  //       cancelText: cancelText,
  //       onCancelPressed: onCancelPressed,
  //       okText: okText,
  //       onOkPressed: onOkPressed,
  //       left: left,
  //     );

  @protected
  isEmpty(value) => StringUtil.isEmpty(value);

  @protected
  isNotEmpty(value) => !isEmpty(value);

  @protected
  isTrue(value) => value != null && value is bool && value;

  Widget buildLodingWidget() {
    return Center(
      child: Theme(
        data: ThemeData(
            cupertinoOverrideTheme:
                CupertinoThemeData(brightness: Brightness.light)),
        child: const CupertinoActivityIndicator(radius: 14.0),
      ),
    );
  }

  @protected
  bottomSheetListMenu<T>(String title, List<T> item,
          {ValueChanged<int> voidItemCallback,
          BuildCheckChild<T> buildCheckChild}) =>
      showBottomPopup(context, title, item, buildCheckChild: buildCheckChild)
          .then(voidItemCallback);

  @protected
  bottomDialog(Widget child, {bool barrierDismissible = true}) {
    showBottomDialog(context, child, barrierDismissible: barrierDismissible);
  }

  /// 单个录入对话框
  @protected
  inputDialog(ValueChanged<String> inputCallback,
          {String label,
          String message,
          ValueChanged<String> cancelCallback,
          String content,
          String hintText,
          String title,
          String cancelText,
          TextInputType inputType,
          String okText}) =>
      showInputDialog(context, inputCallback,
          cancelCallback: cancelCallback,
          message: message,
          label: label,
          content: content,
          hintText: hintText,
          title: title,
          okText: okText,
          inputType: inputType,
          cancelText: cancelText);

  bool isTure(flag) => flag != null && flag is bool && flag;
}
