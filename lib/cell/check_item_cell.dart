import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

/// 单选控件
Widget buildRadioCell(
    {String label,
    ValueChanged<bool> onSelected,
    Color labelColor = Colors.black87,
    bool selected = false,
    Color selectColor = Colors.blue,
    TextStyle labelTextStyle}) {
  return FilterChip(
    label: Text(label ?? ''),
    labelStyle: labelTextStyle ?? TextStyle(fontSize: 14, color: labelColor),
    avatar: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? Colors.blue : Colors.black87,
        size: 14),
    backgroundColor: Colors.white,
    padding: EdgeInsets.all(0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
    onSelected: (seleced) {
      if (onSelected != null) onSelected(seleced);
    },
  );
}

/// 复选控件
Widget buildCheckCell(
    {String label,
    Color labelColor = Colors.black87,
    TextStyle labelTextStyle,
    bool selected = false,
    Color selectColor = Colors.blue,
    ValueChanged<bool> onSelected,
    EdgeInsets padding}) {
  return Container(
    alignment: Alignment.centerLeft,
    child: InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected(!selected);
        }
      },
      child: Container(
        padding: padding ?? EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(selected ? Icons.check_box : Icons.check_box_outline_blank,
                color: selected ? Colors.blue : Colors.black54, size: 18),
            SizedBox(width: 5),
            Text(
              label ?? '',
              overflow: TextOverflow.ellipsis,
              style:
                  labelTextStyle ?? TextStyle(fontSize: 16, color: labelColor),
            )
          ],
        ),
      ),
    ),
  );
}

/// 选择菜单
Widget buildCheckItem(String label, bool selected,
    {Color color = MiniColor.white, String iconUrl}) {
  List<Widget> items = [];
  if (iconUrl != null && UrlUtil.isUrl(iconUrl)) {
    items
      ..add(Image.network(iconUrl, width: 38, height: 28, fit: BoxFit.cover))
      ..add(SizedBox(width: 8));
  }
  items.addAll([
    Text(
      label ?? '',
      style: selected
          ? TextStyle(
              fontSize: 14.0,
              color: MiniColor.blue,
              fontWeight: FontWeight.w400)
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
      child:
          Row(children: items, crossAxisAlignment: CrossAxisAlignment.center));
}

/// 一级菜单标题
Widget buildFirstCheckItem(BuildContext context, String label, bool selected) {
  if (!selected) {
    return DecoratedBox(
        decoration: BoxDecoration(
            border: Border(right: Divider.createBorderSide(context))),
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
            border: Border(
                top: Divider.createBorderSide(context),
                bottom: Divider.createBorderSide(context))),
        child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: <Widget>[
                Container(color: MiniColor.blue, width: 3.0, height: 20.0),
                Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(label ?? '')),
              ],
            )));
  }
}

/// 二级菜单
Widget buildSubCheckItem(BuildContext context, String label, bool selected) {
  Color color = selected
      ? Theme.of(context).primaryColor
      : Theme.of(context).textTheme.body1.color;
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
