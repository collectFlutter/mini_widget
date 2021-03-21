import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

import '../typedef.dart';

/// 选择组件，支持单选和多选
class SelectWidget<T> extends StatefulWidget {
  final String checkKey = 'check';
  final String itemKey = 'item';
  final String titleKey = 'title';
  final List<T> data;
  final List<T> selectedData;
  final Compare<T> compare;
  final BuildCheckChild<T> buildCheckChild;
  final _SelectWidgetState _state = _SelectWidgetState();

  /// 是否支持多选
  final bool multiple;

  SelectWidget(this.data,
      {this.buildCheckChild,
      this.selectedData,
      this.compare,
      this.multiple = true});

  @override
  _SelectWidgetState createState() => _state;

  void search(String searchKey) => _state._search(searchKey);

  /// 获取选择的内容
  List<T> getSelected() {
    List<T> temp = [];
    _state.items.forEach((item) {
      if (item[checkKey]) temp.add(item[itemKey]);
    });
    return temp;
  }
}

class _SelectWidgetState extends State<SelectWidget> {
  List bases = [];
  List items = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.data.length; ++i) {
      var item = widget.data[i];
      bool flag = false;
      // 匹配已经选择的内容
      if (widget.selectedData != null && widget.selectedData.length > 0) {
        for (var i = 0; i < widget.selectedData.length; ++i) {
          if (widget.compare != null) {
            if (widget.compare(item, widget.selectedData[i]) == 0) {
              flag = true;
              break;
            }
          } else {
            if (widget.selectedData[i][widget.titleKey] ==
                item[widget.titleKey]) {
              flag = true;
              break;
            }
          }
        }
      }
      items.add({widget.checkKey: flag, widget.itemKey: item});
    }
    bases.addAll(items);
  }

  void _search(String searchKey) {
    if (StringUtil.isEmpty(searchKey)) {
      items.clear();
      items.addAll(bases);
    } else {
      items.clear();
      if (bases.any((i) => i.toString().contains(searchKey))) {
        items.addAll(bases.where((i) => i.toString().contains(searchKey)));
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool all = items.any((item) => !item[widget.checkKey]);
    List<Widget> checkItem = [];
    for (var i = 0; i < items.length; ++i) {
      checkItem.add(Container(
        color: MiniColor.white,
        child: CheckboxListTile(
          value: items[i][widget.checkKey],
          onChanged: (value) {
            if (widget.multiple) {
              items[i][widget.checkKey] = value;
            } else {
              if (items[i][widget.checkKey] != true) {
                items.forEach((f) => f[widget.checkKey] = false);
                items[i][widget.checkKey] = true;
              }
            }
            setState(() {});
          },
          title: widget.buildCheckChild != null
              ? widget.buildCheckChild(context, items[i][widget.itemKey])
              : Text(
                  items[i][widget.itemKey][widget.titleKey],
                  style: TextStyle(fontSize: MiniDimen.fontNormal),
                ),
        ),
      ));
      checkItem.add(SizedBox(height: 1));
    }

    return Column(
      children: <Widget>[
        widget.multiple
            ? Container(
                color: MiniColor.white,
                child: CheckboxListTile(
                  value: !all,
                  title: Text('全选'),
                  onChanged: (value) {
                    for (var i = 0; i < items.length; ++i) {
                      items[i][widget.checkKey] = value;
                    }
                    setState(() {});
                  },
                ))
            : SizedBox(height: 1),
        SizedBox(height: 1),
        Expanded(
          child: ListView(children: checkItem),
        )
      ],
    );
  }
}
