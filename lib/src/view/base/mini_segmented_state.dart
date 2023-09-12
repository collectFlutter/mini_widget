import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mixin_state.dart';

/// 分段页面
abstract class MiniSegmentedState<T extends StatefulWidget> extends State<T>
    with StateMixin {
  List<SegmentedModel> _items = [];

  int tabIndex = 0;

  Widget? buildFloatingActionButton() => null;

  Widget? buildNavigationButton() => null;

  Widget? buildTitle();

  Widget? buildEmptyWidget() => Container();

  Widget buildSegmentedBar(int index) => Container(
        width: 110,
        alignment: Alignment.center,
        child: Text(
          _items[index].label,
          style:
              TextStyle(color: index == tabIndex ? Colors.blue : Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  List<SegmentedModel> initSegmented();

  @override
  void initState() {
    _items = initSegmented();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int size = _items.length;
    if (size == 0 || size == 1) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          leading: buildBackButton(),
          title: buildTitle(),
          centerTitle: true,
        ),
        body: size == 0 ? buildEmptyWidget() : _items[0].child,
        floatingActionButton: buildFloatingActionButton(),
        bottomNavigationBar: buildNavigationButton(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        leading: buildBackButton(),
        title: Container(
          padding: const EdgeInsets.only(right: 40),
          alignment: Alignment.center,
          child: CupertinoSlidingSegmentedControl<int>(
            onValueChanged: onPageChange,
            groupValue: tabIndex,
            children: List.generate(
              _items.length,
              (index) => buildSegmentedBar(index),
            ).asMap(),
          ),
        ),
      ),
      body: IndexedStack(
        index: tabIndex,
        children: _items.map((f) => f.child).toList(),
      ),
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: buildNavigationButton(),
    );
  }

  /// 界面切换
  void onPageChange(int? index) {
    if (index == null) return;
    setState(() => tabIndex = index);
  }
}

class SegmentedModel {
  final String _label;

  String get label => _label;
  final Widget _child;

  Widget get child => _child;

  SegmentedModel(this._label, this._child);
}
