import 'package:flutter/material.dart';

import '../mini_widget.dart';
import '../tools.dart';

/// 多选Or单选界面，成功后，返回 List<T> 对象
// ignore: must_be_immutable
class SelectPage<T> extends MiniDetailPage {
  final String title;
  final bool showSearchBar;
  final TextEditingController controller = TextEditingController();
  final List<T> data;
  final BuildCheckChild<T> buildCheckChild;
  final List<T> selectedData;
  final Compare<T> compare;
  final bool multiple;
  SelectWidget<T> _child;

  SelectPage(
    this.title,
    this.data, {
    this.buildCheckChild,
    this.selectedData,
    this.compare,
    this.multiple = true,
    this.showSearchBar = false,
  }) {
    _child = SelectWidget<T>(data,
        buildCheckChild: buildCheckChild,
        selectedData: selectedData,
        compare: compare,
        multiple: multiple);
    controller.addListener(() {
      _child?.search(controller.text.trim());
    });
  }

  @override
  Widget buildBody(BuildContext context) {
    return _child;
  }

  @override
  Widget buildEndDrawer(BuildContext context) {
    return null;
  }

  @override
  Widget buildNavigationButton(BuildContext context) {
    return RaisedButton(
      textColor: MiniColor.white,
      child: Text('确定'),
      onPressed: () {
        List<T> temp = _child.getSelected();
        if (temp.length == 0) {
          showMessage('未选择任何内容！', context);
          return;
        } else {
          back(context, success: true, items: temp);
        }
      },
    );
  }

  @override
  Widget buildTitle(BuildContext context) {
    return showSearchBar
        ? buildSearchCell(controller: controller, hint: title ?? '')
        : Text(title ?? '');
  }

  @override
  void back(BuildContext context, {bool success, List<T> items}) {
    if (isEmpty(success) || !success) {
      super.back(context);
    } else {
      Navigator.pop(context, items);
    }
  }
}
