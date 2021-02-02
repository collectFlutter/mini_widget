// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:mini_tools/mini_tools.dart';
// import 'package:mini_widget/util/navigator_util.dart';
//
//
// abstract class MiniState<T extends StatefulWidget> extends State<T> with RouteAware {
//   /// 用的 TextEditingController 的时候，记得丢到这里，会自动销毁
//   List<TextEditingController> textControllers = [];
//
//   @override
//   initState() {
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback(afterBuild);
//   }
//
//   /// 页面首次构建结束回调
//   @protected
//   void afterBuild(Duration timestamp) {}
//
//   @override
//   void dispose() {
//     textControllers.forEach((_controller) {
//       _controller?.dispose();
//     });
//     textControllers.clear();
//     super.dispose();
//   }
//
//   @protected
//   void back({@required bool success}) {
//     if (isEmpty(success) || !success) {
//       MiniNavigatorUtil.pop(context);
//     } else {
//       MiniNavigatorUtil.pop(context,success:success);
//     }
//   }
//
//   @protected
//   Future<dynamic> pushPage(Widget page) async {
//     if (page == null) return null;
//     print(page);
//     return await MiniNavigatorUtil.pushPage(context, page);
//   }
//
//   @protected
//   isEmpty(value) => StringUtil.isEmpty(value);
//
//   @protected
//   isNotEmpty(value) => !isEmpty(value);
//
//   @protected
//   isTure(value) => value != null && value is bool && value;
//
//   /// 显示底部对话框
//   @protected
//   bottomSheetListMenu<T>(String title, List<T> item,
//           {ValueChanged<int> voidItemCallback, BuildCheckChild<T> buildCheckChild}) =>
//       showBottomPopup(context, title, item, buildCheckChild: buildCheckChild).then(voidItemCallback);
//
//   /// 等待对话框
//   @protected
//   loadingDialog() => showLoadingDialog(context);
//
//   /// 退出Navigator
//   @protected
//   pop() => Navigator.pop(context);
//
//   /// 单个录入对话框
//   @protected
//   inputDialog(ValueChanged<String> inputCallback,
//           {String label,
//           String message,
//           ValueChanged<String> cancelCallback,
//           String content,
//           String hintText,
//           String title,
//           String cancelText,
//           TextInputType inputType,
//           String okText}) =>
//       showInputDialog(context, inputCallback,
//           cancelCallback: cancelCallback,
//           message: message,
//           label: label,
//           content: content,
//           hintText: hintText,
//           title: title,
//           okText: okText,
//           inputType: inputType,
//           cancelText: cancelText);
//
//   /// 默认对话框
//   @protected
//   defaultDialog(String content,
//           {String title,
//           String colorContent = '',
//           String cancelText,
//           onCancelPressed,
//           String okText,
//           VoidCallback onOkPressed,
//           bool left = false}) =>
//       showMassageDialog(context, content,
//           title: title,
//           colorContent: colorContent,
//           cancelText: cancelText,
//           onCancelPressed: onCancelPressed,
//           okText: okText,
//           onOkPressed: onOkPressed,
//           left: left);
//
//   /// 底部对话框
//   @protected
//   bottomDialog(Widget child, {bool barrierDismissible = true}) {
//     showBottomDialog(context, child, barrierDismissible: barrierDismissible);
//   }
// }
