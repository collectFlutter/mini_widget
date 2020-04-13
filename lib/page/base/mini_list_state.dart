import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../cell/a.dart';

import '../../tools.dart';
import 'mini_state.dart';

/// 列表组件
abstract class MiniListState<T extends StatefulWidget, M> extends MiniState<T> with AutomaticKeepAliveClientMixin {
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
    return Material(
      color: getBackgroundColor(),
      child: Container(
        child: EasyRefresh(
          firstRefresh: firstRefresh(),
          emptyWidget: showEmptyWidget
              ? buildEmptyWidget(
                  emptyImageAsset: getEmptyImageAsset(),
                  emptyMessage: getEmptyMessage(),
                  child: getEmptyChild(),
                )
              : list.length == 0
                  ? buildLoadingListWidget(
                      itemChild: getLodingChild(),
                      baseColor: getLodingBaseColor(),
                      highlightColor: getLodingHighlightColor(),
                    )
                  : null,
          child: ListView.builder(
            controller: ScrollController(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (ctx, index) => (index == list.length - 1)
                ? Column(children: <Widget>[buildItemCell(ctx, list[index], index), SizedBox(height: 80)])
                : buildItemCell(ctx, list[index], index),
          ),
          onRefresh: hasRefresh() ? () => fetchData(false) : null,
          onLoad: hasMore() ? () => fetchData(true) : null,
        ),
      ),
    );
  }

  Widget getLodingChild() => null;

  Color getLodingBaseColor() => Colors.grey[300];

  Color getLodingHighlightColor() => Colors.grey[100];

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
    if (value.length < 1) {
      if (more)
        showMessage('无更多数据！', context);
      else if (show) showMessage("暂无数据", context);
    } else {
      if (!more) list.clear();
      list.addAll(value);
    }
    showEmptyWidget = list.length == 0;
    if (mounted) setState(() {});
  }

  Widget buildItemCell(BuildContext ctx, M item, int index);

  @override
  bool get wantKeepAlive => false;
}
