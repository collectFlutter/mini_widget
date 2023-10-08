import 'package:flutter/material.dart';

///
/// [hint] - 搜索提示 <br/>
/// [enInput] - 是否可以录入 <br/>
Widget buildSearchCell({
  String hint = '多关键字用空格分开搜索',
  TextEditingController? controller,
  bool enInput = true,
  ValueChanged<String>? onSubmitted,
  ValueChanged<String>? onChanged,
}) {
  return Container(
    height: 30,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: const Color(0xFFF7F6F6),
        borderRadius: BorderRadius.circular(26.0)),
    child: TextField(
      controller: controller,
      enabled: enInput,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, size: 16),
        hintText: hint,
        helperStyle: const TextStyle(
            textBaseline: TextBaseline.ideographic, height: 1.1),
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      style: const TextStyle(
          fontSize: 14, textBaseline: TextBaseline.ideographic, height: 1.1),
    ),
  );
}
