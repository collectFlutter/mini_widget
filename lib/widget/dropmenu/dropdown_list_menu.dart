import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dropdown_common.dart';

typedef Widget MenuItemBuilder<T>(BuildContext context, T data, bool selected);
typedef void MenuItemOnTap<T>(T data, int index);
typedef void MenuTreeOnTap<T, E>(T data, int index, E subData, int subIndex);
typedef List<E> GetSubData<T, E>(T data);

const double kDropdownMenuItemHeight = 45.0;

class DropdownListMenu<T> extends DropdownWidget {
  final List<T> data;
  final int selectedIndex;
  final MenuItemBuilder<T> itemBuilder;
  final MenuItemOnTap<T> menuItemOnTap;
  final ValueChanged<List<T>> onMultiSelected;
  final double itemExtent;
  final bool multi;

  DropdownListMenu(
      {this.data,
      this.multi = false,
      this.selectedIndex,
      this.itemBuilder,
      this.itemExtent: kDropdownMenuItemHeight,
      this.onMultiSelected,
      this.menuItemOnTap});

  @override
  DropdownState<DropdownWidget> createState() {
    return _MenuListState<T>();
  }
}

class _MenuListState<T> extends DropdownState<DropdownListMenu<T>> {
  List<CheckItem<T>> _list;
  int _selectedIndex;
  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    _list = List.generate(
        widget.data.length,
        (index) =>
            CheckItem(check: index == _selectedIndex, t: widget.data[index]));
    super.initState();
  }

  Widget buildItem(BuildContext context, int index) {
    // final List<T> list = widget.data;

    final T data = _list[index].t;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.itemBuilder(context, data, _list[index].check),
      onTap: () {
        assert(controller != null);
        if (widget.multi) {
          _list[index].check = !_list[index].check;
          setState(() {});
        } else {
          if (widget.menuItemOnTap != null) widget.menuItemOnTap(data, index);
          _selectedIndex = index;
          List.generate(
              _list.length,
              (generator) =>
                  _list[generator].check = generator == _selectedIndex);
          setState(() {});
          controller.select(data, index: index);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.multi) {
      return Stack(
        children: <Widget>[
          Container(
            child: _buildMenuView(),
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 45),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 5,
            child: _buildBottomBar(),
          )
        ],
      );
    }
    return _buildMenuView();
  }

  _buildMenuView() {
    return ListView.builder(
      itemExtent: widget.itemExtent,
      itemBuilder: buildItem,
      itemCount: widget.data.length,
    );
  }

  _buildBottomBar() {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
        ),
        RaisedButton(
          textColor: Colors.white,
          child: Text('确定'),
          onPressed: () {
            if (widget.onMultiSelected != null) {
              List<T> l = [];
              _list.forEach((f) {
                if (f.check) l.add(f.t);
              });
              widget.onMultiSelected(l);
            }
            controller.select({});
          },
        )
      ],
    );
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        {}
        break;
      case DropdownEvent.ACTIVE:
        {}
        break;
    }
  }
}

class CheckItem<T> {
  bool check;
  T t;
  CheckItem({this.check = false, this.t});
}

/// This widget is just like this:
/// ----------------|---------------------
/// MainItem1       |SubItem1
/// MainItem2       |SubItem2
/// MainItem3       |SubItem3
/// ----------------|---------------------
/// When you tap "MainItem1", the sub list of this widget will
/// 1. call `getSubData(widget.data[0])`, this will return a list of data for sub list
/// 2. Refresh the sub list of the widget by using the list above.
///
///
class DropdownTreeMenu<T, E> extends DropdownWidget {
  /// data from this widget
  final List<T> data;

  /// selected index of main list
  final int selectedIndex;

  /// item builder for main list
  final MenuItemBuilder<T> itemBuilder;

  //selected index of sub list
  final int subSelectedIndex;

  /// A function to build right item of the tree
  final MenuItemBuilder<E> subItemBuilder;

  /// A callback to get sub list from left list data, eg.
  /// When you set List<MyData> to left,
  /// a callback (MyData data)=>data.children; must be provided
  final GetSubData<T, E> getSubData;

  /// `itemExtent` of main list
  final double itemExtent;

  /// `itemExtent` of sub list
  final double subItemExtent;

  /// background for main list
  final Color background;

  /// background for sub list
  final Color subBackground;

  /// flex for main list
  final int flex;

  /// flex for sub list,
  /// if `subFlex`==2 and `flex`==1,then sub list will be 2 times larger than main list
  final int subFlex;

  final MenuTreeOnTap menuTreeOnTap;

  DropdownTreeMenu({
    this.data,
    double itemExtent,
    this.selectedIndex,
    this.itemBuilder,
    this.subItemExtent,
    this.subItemBuilder,
    this.getSubData,
    this.background: const Color(0xfffafafa),
    this.subBackground,
    this.flex: 1,
    this.subFlex: 2,
    this.subSelectedIndex,
    this.menuTreeOnTap,
  })  : assert(getSubData != null),
        itemExtent = itemExtent ?? kDropdownMenuItemHeight;

  @override
  DropdownState<DropdownWidget> createState() {
    return _TreeMenuList();
  }
}

class _TreeMenuList<T, E> extends DropdownState<DropdownTreeMenu> {
  int _subSelectedIndex;
  int _selectedIndex;

  //
  int _activeIndex;

  List<E> _subData;

  List<T> _data;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    _subSelectedIndex = widget.subSelectedIndex;
    _activeIndex = _selectedIndex;

    _data = widget.data;

    if (_activeIndex != null) {
      _subData = widget.getSubData(_data[_activeIndex]);
    }

    super.initState();
  }

  @override
  void didUpdateWidget(DropdownTreeMenu oldWidget) {
    // _selectedIndex = widget.selectedIndex;
    // _subSelectedIndex = widget.subSelectedIndex;
    // _activeIndex = _selectedIndex;

    super.didUpdateWidget(oldWidget);
  }

  Widget buildSubItem(BuildContext context, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.subItemBuilder(context, _subData[index],
          _activeIndex == _selectedIndex && index == _subSelectedIndex),
      onTap: () {
        assert(controller != null);

        _selectedIndex = _activeIndex;
        _subSelectedIndex = index;

        if (widget.menuTreeOnTap != null)
          widget.menuTreeOnTap(_data[_activeIndex], _activeIndex,
              _subData[_subSelectedIndex], _subSelectedIndex);
        controller.select(_subData[_subSelectedIndex],
            index: _activeIndex, subIndex: _subSelectedIndex);
        setState(() {});
      },
    );
  }

  Widget buildItem(BuildContext context, int index) {
    final List<T> list = widget.data;
    final T data = list[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: widget.itemBuilder(context, data, index == _activeIndex),
      onTap: () {
        //切换
        //拿到数据
        setState(() {
          _subData = widget.getSubData(data);
          _activeIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: widget.flex,
            child: Container(
              child: ListView.builder(
                itemExtent: widget.itemExtent,
                itemBuilder: buildItem,
                itemCount: this._data == null ? 0 : this._data.length,
              ),
              color: widget.background,
            )),
        Expanded(
            flex: widget.subFlex,
            child: Container(
              color: widget.subBackground,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    buildSubItem,
                    childCount:
                        this._subData == null ? 0 : this._subData.length,
                  ))
                ],
              ),
            ))
      ],
    );
  }

  @override
  void onEvent(DropdownEvent event) {
    // TODO: implement onEvent
  }
}
