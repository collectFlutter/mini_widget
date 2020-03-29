import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

Widget buildCheckItem(String label, bool selected, {Color color = MiniColor.white, String iconUrl}) {
  List<Widget> items = [];
  if (iconUrl != null && UrlUtil.isUrl(iconUrl)) {
    items..add(Image.network(iconUrl, width: 38, height: 28, fit: BoxFit.cover))..add(SizedBox(width: 8));
  }
  items.addAll([
    Text(
      label ?? '',
      style: selected
          ? TextStyle(fontSize: 14.0, color: MiniColor.blue, fontWeight: FontWeight.w400)
          : TextStyle(fontSize: 14.0),
    ),
    Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: selected ? Icon(Icons.check, color: MiniColor.blue) : null,
      ),
    ),
  ]);

  return Container(
      color: color,
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(children: items, crossAxisAlignment: CrossAxisAlignment.center));
}

/// 一级菜单标题
Widget buildFirstCheckItem(BuildContext context, String label, bool selected) {
  if (!selected) {
    return DecoratedBox(
        decoration: BoxDecoration(border: Border(right: Divider.createBorderSide(context))),
        child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                Text(label ?? ''),
              ],
            )));
  } else {
    return DecoratedBox(
        decoration: BoxDecoration(
            border: Border(top: Divider.createBorderSide(context), bottom: Divider.createBorderSide(context))),
        child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: <Widget>[
                Container(color: MiniColor.blue, width: 3.0, height: 20.0),
                Padding(padding: EdgeInsets.only(left: 12.0), child: Text(label ?? '')),
              ],
            )));
  }
}

/// 二级菜单
Widget buildSubCheckItem(BuildContext context, String label, bool selected) {
  Color color = selected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.body1.color;
  return SizedBox(
    height: 45.0,
    child: Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              label ?? '',
              style: TextStyle(color: color),
            )),
      ],
    ),
  );
}
