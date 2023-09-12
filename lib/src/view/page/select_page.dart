import 'package:flutter/material.dart';
import 'package:mini_widget/src/view/toast.dart';

import '../base/_.dart';
import '../typedef.dart';
import '../widget/mini_search_widget.dart';
import '../widget/select_widget.dart';

/// 多选Or单选界面，成功后，返回 List<T> 对象
// ignore: must_be_immutable
class SelectPage<T> extends MiniDetailPage {
  final String title;
  final bool showSearchBar;
  final TextEditingController controller = TextEditingController();
  final List<T> data;
  final BuildCheckChild<T>? buildCheckChild;
  final List<T>? selectedData;
  final Compare<T>? compare;
  final bool multiple;
  final GlobalKey<SelectWidgetState<T>> _listKey = GlobalKey();

  SelectPage(
    this.title,
    this.data, {
    super.key,
    this.buildCheckChild,
    this.selectedData,
    this.compare,
    this.multiple = true,
    this.showSearchBar = false,
  }) {
    controller.addListener(() {
      _listKey.currentState?.search(controller.text.trim());
    });
  }

  @override
  Widget? buildBody(BuildContext context) {
    return SelectWidget<T>(data,
        key: _listKey,
        buildCheckChild: buildCheckChild,
        selectedData: selectedData,
        compare: compare,
        multiple: multiple);
  }

  @override
  Widget? buildEndDrawer(BuildContext context) {
    return null;
  }

  @override
  Widget buildNavigationButton(BuildContext context) {
    return ElevatedButton(
      child: const Text('确定'),
      onPressed: () {
        List<T> temp = _listKey.currentState?.getSelected() ?? [];
        if (temp.isEmpty) {
          ToastUtil.showError('未选择任何内容！');
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
        ? MiniSearchWidget(controller: controller, hintText: title)
        : Text(title);
  }

  @override
  void back(BuildContext context,
      {bool success = false, List items = const []}) {
    if (isEmpty(success) || !success) {
      super.back(context);
    } else {
      Navigator.pop(context, items);
    }
  }
}
