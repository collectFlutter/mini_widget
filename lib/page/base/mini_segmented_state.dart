import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_widget/res/a.dart';

import 'mixin_state.dart';

/// 分段页面
abstract class MiniSegmentedState<T extends StatefulWidget> extends State<T>
    with StateMixin {
  List<SegmentedModel> _items;

  int tabIndex = 0;

  Widget buildFloatingActionButton() => null;
  Widget buildNavigationButton() => null;
  Widget buildTitle();

  Widget buildEmptyWidget() => Container();

  Widget buildSegmentedBar(String label) => Container(
        width: 110,
        alignment: Alignment.center,
        child: Text(
          label ?? '',
          style: TextStyle(fontSize: MiniDimen.fontSmall),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Color getSelectedColor() => Theme.of(context).scaffoldBackgroundColor;

  Color getUnSelectedColor() => Theme.of(context).primaryColorDark;

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
        appBar: AppBar(title: buildTitle(), centerTitle: true),
        body: size == 0 ? buildEmptyWidget() : _items[0].child,
        floatingActionButton: buildFloatingActionButton(),
        bottomNavigationBar: buildNavigationButton(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(right: 40),
          alignment: Alignment.center,
          child: CupertinoSegmentedControl<int>(
            selectedColor: getSelectedColor(),
            unselectedColor: getUnSelectedColor(),
            onValueChanged: (index) => setState(() => tabIndex = index),
            children:
                _items.map((f) => buildSegmentedBar(f.label)).toList().asMap(),
            groupValue: tabIndex,
          ),
        ),
      ),
      body: IndexedStack(
          children: _items.map((f) => f.child).toList(), index: tabIndex),
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: buildNavigationButton(),
    );
  }
}

class SegmentedModel {
  String _label;
  String get label => _label;
  Widget _child;
  Widget get child => _child;
  SegmentedModel(this._label, this._child);
}
