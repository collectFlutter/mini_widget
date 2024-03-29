import 'package:flutter/material.dart';

import 'mini_list_state.dart';

/// 表格列表，支持左右滑动
abstract class MiniTabListState<T extends StatefulWidget, M>
    extends MiniListState<T, M> {
  final ScrollController controllerTitle;

  final List<ScrollController> controllers = [];

  MiniTabListState(this.controllerTitle);

  @override
  dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controllerTitle.addListener(() {
      for (var item in controllers) {
        item.jumpTo(controllerTitle.offset);
      }
    });
    controllers.clear();
    return super.build(context);
  }

  @override
  buildItemCell(BuildContext ctx, M item, int index) {
    controllers.add(ScrollController());
    return buildTabItemCell(ctx, item, index, controllers.last);
  }

  Widget buildTabItemCell(
      BuildContext ctx, M item, int index, ScrollController controller);
}
