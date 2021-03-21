import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_widget/dialog/bottom_dialog.dart';
import 'package:mini_widget/res/colors.dart';

import '../typedef.dart';

/// [onItemSelected] -1 代表无数据
Widget buildTagSelectCell<T>(
  BuildContext context,
  String tag, {
  IconData iconData = Icons.keyboard_arrow_down,
  double tagWidth = 80,
  String hintText,
  TextEditingController controller,
  TextInputType inputType,
  InputDecoration inputDecoration,
  List<T> items,
  BuildCheckChild<T> buildCheckChild,
  VoidCallback onTap,
  bool required = false,
  bool isEdit = true,
  int valueMaxLines = 1,
  double paddingRight = 0.0,
  EdgeInsetsGeometry padding = const EdgeInsets.all(1),
  bool showLine = false,
  Color color = Colors.white,
  Widget child,
  ValueChanged<int> onItemSelected,
}) {
  return Material(
    color: color,
    child: Ink(
      child: InkWell(
        onTap: isEdit
            ? (onItemSelected == null
                ? onTap
                : () {
                    if (items == null || items.length < 1) {
                      onItemSelected(-1);
                    }
                    showBottomPopup(context, '请选择$tag', items,
                            buildCheckChild: buildCheckChild)
                        .then((index) {
                      if (index == null || index < 0) return;
                      onItemSelected(index);
                    });
                  })
            : null,
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
                            style:
                                TextStyle(color: MiniColor.gray, height: 1.1),
                          ),
                        ),
                        required
                            ? Icon(MdiIcons.multiplication,
                                size: 8, color: MiniColor.red)
                            : Container(),
                      ],
                    )),
                Expanded(
                  child: child ??
                      TextField(
                        enabled: false,
                        enableInteractiveSelection: false,
                        controller: controller,
                        keyboardType: inputType ?? TextInputType.text,
                        decoration: inputDecoration ??
                            InputDecoration(
                                hintText: hintText ?? '请选择$tag',
                                hasFloatingPlaceholder: false,
                                border: InputBorder.none),
                        style: TextStyle(height: 1.1),
                      ),
                ),
                isEdit ? Icon(iconData, color: MiniColor.blue) : Container(),
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
