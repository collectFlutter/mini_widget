import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mini_widget/widget/empty_widget.dart';
import 'package:mini_widget/widget/loading_list_widget.dart';
import 'mixin_state.dart';

/// 列表组件
abstract class MiniListState<T extends StatefulWidget, M> extends State<T>
    with StateMixin, AutomaticKeepAliveClientMixin {
  bool isEdited = false;
  List<M> list = [];
  int pageIndex = 1;
  bool showEmptyWidget = false;

  @override
  void afterBuild(Duration timestamp) {
    if (!hasRefresh()) {
      fetchData(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Material(
        color: getBackgroundColor(),
        child: Container(
          child: EasyRefresh(
            firstRefresh: firstRefresh(),
            emptyWidget: showEmptyWidget
                ? EmptyWidget(
                    emptyImageAsset: getEmptyImageAsset(),
                    emptyMessage: getEmptyMessage(),
                    child: getEmptyChild())
                : list.length == 0
                    ? LoadingListWidget(
                        itemChild: getLoadingChild(),
                        baseColor: getLoadingBaseColor(),
                        highlightColor: getLoadingHighlightColor())
                    : null,
            child: ListView.builder(
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (ctx, index) =>
                  buildItemCell(ctx, list[index], index),
            ),
            onRefresh: hasRefresh() ? () => fetchData(false) : null,
            onLoad: hasMore() ? () => fetchData(true) : null,
          ),
        ),
      ),
      onWillPop: onSystemBack,
    );
  }

  Widget getLoadingChild() => null;

  Color getLoadingBaseColor() => Colors.grey[300];

  Color getLoadingHighlightColor() => Colors.grey[100];

  Widget getEmptyChild() => null;

  String getEmptyImageAsset();

  String getEmptyMessage() => '暂无内容';

  bool firstRefresh() => true;

  bool hasRefresh() => true;

  bool hasMore() => true;

  Color getBackgroundColor() => Theme.of(context).backgroundColor;

  fetchData(bool more) async {
    if (more) {
      pageIndex += 1;
    } else {
      pageIndex = 1;
      list.clear();
    }
  }

  void updateListUI(bool more, List<M> value, {bool show = true}) {
    if (value == null) return;
    if (value.length > 0) {
      if (!more) list.clear();
      list.addAll(value);
    }
    showEmptyWidget = list.length == 0;
    if (mounted) setState(() {});
  }

  Widget buildItemCell(BuildContext ctx, M item, int index);

  @override
  bool get wantKeepAlive => false;

  @protected
  Future<bool> onSystemBack() async {
    back(success: isEdited);
    return false;
  }
}
