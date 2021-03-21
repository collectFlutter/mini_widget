import 'package:flutter/material.dart';

///
/// [hint] - 搜索提示 <br/>
/// [enInput] - 是否可以录入 <br/>
Widget buildSearchCell({
  String hint = '多关键字用空格分开搜索',
  TextEditingController controller,
  bool enInput = true,
  ValueChanged<String> onSubmitted,
  ValueChanged<String> onChanged,
}) {
  return Container(
    height: 30,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Color(0xFFF7F6F6), borderRadius: BorderRadius.circular(26.0)),
    child: TextField(
      controller: controller,
      enabled: enInput,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, size: 16),
        hintText: hint,
        helperStyle:
            TextStyle(textBaseline: TextBaseline.ideographic, height: 1.1),
        hasFloatingPlaceholder: false,
        border: InputBorder.none,
      ),
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      style: TextStyle(
          fontSize: 14, textBaseline: TextBaseline.ideographic, height: 1.1),
    ),
  );
}
