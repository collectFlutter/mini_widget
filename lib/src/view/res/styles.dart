import 'package:flutter/widgets.dart';

import 'dimens.dart';
import 'colors.dart';

class MiniStyle {
  static const TextStyle textTitle = TextStyle(
      fontSize: MiniDimen.fontLarge,
      color: MiniColor.textDark,
      fontWeight: FontWeight.bold);
  static const TextStyle textNormal =
      TextStyle(fontSize: MiniDimen.fontNormal, color: MiniColor.textNormal);
  static const TextStyle textTag =
      TextStyle(fontSize: MiniDimen.fontSmall, color: MiniColor.textGray);
  static const TextStyle textUrl =
      TextStyle(fontSize: MiniDimen.fontNormal, color: MiniColor.blue);

  static const EdgeInsetsGeometry tagPadding =
      EdgeInsets.only(top: 5, bottom: 5);
  static const EdgeInsetsGeometry conPadding = EdgeInsets.all(10);
  static const TextStyle headStyle = TextStyle(fontSize: MiniDimen.fontLarge);
  static const TextStyle textGrayCNormal =
      TextStyle(fontSize: MiniDimen.fontNormal, color: MiniColor.textGrayC);
  static const TextStyle textDarkNormal =
      TextStyle(fontSize: MiniDimen.fontNormal, color: MiniColor.textDark);
}
