import 'package:flutter/material.dart';

import 'dropdown_common.dart';

typedef DropdownMenuHeadTapCallback = void Function(int index);

typedef GetItemLabel = String? Function(dynamic data);

String? defaultGetItemLabel(dynamic data) {
  if (data is String) return data;
  if (data is IconData) return null;
  return data["title"];
}

class DropdownHeader extends DropdownWidget {
  final List<dynamic> titles;
  final int? activeIndex;
  final DropdownMenuHeadTapCallback? onTap;

  /// 是否更新头部文本
  final bool updateTitle;

  /// height of menu
  final double height;

  /// get label callback
  late final GetItemLabel getItemLabel;

  DropdownHeader(
      {required this.titles,
      this.activeIndex,
      super.controller,
      this.onTap,
      super.key,
      this.height = 46.0,
      this.updateTitle = true,
      GetItemLabel? getItemLabel}) {
    assert(titles.isNotEmpty);
    getItemLabel = getItemLabel ?? defaultGetItemLabel;
  }

  @override
  DropdownState<DropdownWidget> createState() {
    return _DropdownHeaderState();
  }
}

class _DropdownHeaderState extends DropdownState<DropdownHeader> {
  Widget buildIconItem(
      BuildContext context, IconData iconData, bool selected, int index) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color unselectedColor = Theme.of(context).unselectedWidgetColor;
    return IconButton(
      icon: Icon(
        iconData,
        size: 14,
        color: selected ? primaryColor : unselectedColor,
      ),
      onPressed: () {
        if (widget.onTap != null) {
          widget.onTap!(index);
          return;
        }
        if (controller != null) {
          if (_activeIndex == index) {
            controller!.hide();
            setState(() {
              _activeIndex = null;
            });
          } else {
            controller!.show(index);
          }
        }
      },
    );
  }

  Widget buildItem(
      BuildContext context, dynamic title, bool selected, int index) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color unselectedColor = Theme.of(context).unselectedWidgetColor;
    final GetItemLabel getItemLabel = widget.getItemLabel;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
          child: DecoratedBox(
              decoration: const BoxDecoration(border: null),
              //Border(left: Divider.createBorderSide(context))),
              child: Center(
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Expanded(
                  child: Text(
                    getItemLabel(title) ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? primaryColor : unselectedColor,
                    ),
                  ),
                ),
                Icon(
                  title is IconData
                      ? title
                      : (selected
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down),
                  color: selected ? primaryColor : unselectedColor,
                )
              ])))),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(index);
          return;
        }
        if (controller != null) {
          if (_activeIndex == index) {
            controller!.hide();
            setState(() {
              _activeIndex = null;
            });
          } else {
            controller!.show(index);
          }
        }
        //widget.onTap(index);
      },
    );
  }

  int? _activeIndex;
  List<dynamic> _titles = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    final int activeIndex = _activeIndex ?? 0;
    final List<dynamic> titles = _titles;
    final double height = widget.height;

    for (int i = 0, c = widget.titles.length; i < c; ++i) {
      if (titles[i] is IconData) {
        list.add(buildIconItem(context, titles[i], i == activeIndex, i));
      } else {
        list.add(Expanded(
          child: buildItem(context, titles[i], i == activeIndex, i),
        ));
      }
    }

    return SizedBox(height: height, child: Row(children: list));
  }

  @override
  void initState() {
    _titles = widget.titles;
    super.initState();
  }

  @override
  void onEvent(DropdownEvent event) {
    if (controller == null) {
      return;
    }
    switch (event) {
      case DropdownEvent.select:
        {
          if (_activeIndex == null) return;
          setState(() {
            _activeIndex = null;
            if (!widget.updateTitle ||
                _titles[controller!.menuIndex ?? 0] is IconData) return;
            String? label = widget.getItemLabel(controller!.data);
            _titles[controller!.menuIndex ?? 0] = label;
          });
        }
        break;
      case DropdownEvent.hide:
        {
          if (_activeIndex == null) return;
          setState(() {
            _activeIndex = null;
          });
        }
        break;
      case DropdownEvent.active:
        {
          if (_activeIndex == controller!.menuIndex) return;
          setState(() {
            _activeIndex = controller!.menuIndex;
          });
        }
        break;
    }
  }
}
