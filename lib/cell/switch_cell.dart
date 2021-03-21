import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_widget/res/colors.dart';

Widget buildTagSwitchCell<T>(
  BuildContext context,
  String tag, {
  double tagWidth = 80,
  String hintText,
  String value,
  Color selectedColor = Colors.green,
  Color unSelectedColor = Colors.black,
  Color tagColor = MiniColor.gray,
  ValueChanged<bool> onChange,
  bool required = false,
  bool isEdit = true,
  int valueMaxLines = 1,
  double paddingRight = 0.0,
  EdgeInsetsGeometry padding = const EdgeInsets.all(1),
  bool showLine = false,
  Color color = Colors.white,
  bool selected = false,
}) {
  return Material(
    color: color,
    child: Ink(
      child: InkWell(
        child: Column(children: <Widget>[
          Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: tagWidth,
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            tag,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: tagColor, height: 1.1),
                          ),
                        ),
                        required
                            ? Icon(MdiIcons.multiplication,
                                size: 8, color: MiniColor.red)
                            : Container(),
                      ],
                    )),
                Expanded(
                  child: Text(
                    value ?? '',
                    overflow: valueMaxLines == 1 ? TextOverflow.ellipsis : null,
                    maxLines: valueMaxLines,
                    style: TextStyle(
                        height: 1.1,
                        color: selected ? selectedColor : unSelectedColor),
                  ),
                ),
                CupertinoSwitch(
                    value: selected,
                    onChanged: isEdit ? onChange : null,
                    activeColor: selectedColor),
                SizedBox(width: paddingRight)
              ],
            ),
          ),
          showLine ? Divider(height: 1) : Container(),
        ]),
      ),
    ),
  );
}
