import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

class TabWidget extends StatelessWidget {
  final List<String> headers;
  final double headerHeight;
  final Color headerColor;
  final TextStyle headerTextStyle;
  final List<List<TabBean>> rows;
  final double rowHeight;
  final Color rowColorOne;
  final Color rowColorTwo;
  final double columnItemWidth;

  const TabWidget(
      {Key key,
      this.headers,
      this.rows,
      this.columnItemWidth = 80,
      this.headerHeight = 40,
      this.rowHeight = 45,
      this.rowColorOne = const Color(0xFFE3F2FD),
      this.rowColorTwo = const Color(0xB3FFFFFF),
      this.headerColor,
      this.headerTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _minWidth = headers.length < 6
        ? NumUtil.divide(MediaQuery.of(context).size.width, headers.length) - 2
        : columnItemWidth;
    List<Widget> items = [];
    // 表头
    items.add(
      Container(
          height: headerHeight,
          child: Row(
              children: headers.map((title) {
            return Container(
                color: headerColor ?? Theme.of(context).primaryColor,
                width: _minWidth,
                alignment: Alignment.center,
                child: Text(title,
                    style: headerTextStyle ??
                        MiniStyle.textTag.copyWith(color: MiniColor.white)));
          }).toList())),
    );
    // 表身
    List.generate(rows.length, (index) {
      items.add(
        Container(
          color: index.isOdd ? rowColorOne : rowColorTwo,
          height: rowHeight,
          child: Row(
            children: rows[index].map((rowItem) {
              return GestureDetector(
                onTap: rowItem.onTop,
                child: Container(
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, right: 3, left: 3),
                    width: _minWidth,
                    alignment: Alignment.center,
                    child: Text(rowItem.label,
                        style: MiniStyle.textDarkNormal.copyWith(
                            fontSize: MiniDimen.fontSmall,
                            color: rowItem.color))),
              );
            }).toList(),
          ),
        ),
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(children: items),
      ),
    );
  }
}

class TabBean {
  String label;
  Color color;
  VoidCallback onTop;
  TabBean({this.label, this.color = Colors.black, this.onTop});
}
