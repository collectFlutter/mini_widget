// import 'package:flutter/material.dart';
//
// import '../res/colors.dart';
//
// /// 图标+文字 按钮，左右排序
// Widget buildIconButton(
//   String text, {
//   VoidCallback? onPressed,
//   Icon? icon,
//   Color color = MiniColor.buttonColor,
//   Color textColor = MiniColor.buttonTextColor,
// }) {
//   return Container(
//     height: 44,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(4.0),
//       color: Colors.grey.withOpacity(0.3),
//     ),
//     child: ElevatedButton(
//       child: Stack(
//         children: <Widget>[
//           Container(
//             alignment: Alignment.centerLeft,
//             child: icon ?? Icon(Icons.apps, color: MiniColor.buttonTextColor),
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Text(text),
//           ),
//         ],
//       ),
//       style: ButtonStyle(),
//       color: color,
//       textColor: textColor,
//       onPressed: onPressed,
//     ),
//   );
// }
