import 'package:flutter/material.dart';

/// 间隔
class Gaps {
  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: 4);
  static const Widget hGap5 = SizedBox(width: 5);
  static const Widget hGap8 = SizedBox(width: 8);
  static const Widget hGap10 = SizedBox(width: 10);
  static const Widget hGap12 = SizedBox(width: 12);
  static const Widget hGap15 = SizedBox(width: 15);
  static const Widget hGap16 = SizedBox(width: 16);
  static const Widget hGap32 = SizedBox(width: 32);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: 4);
  static const Widget vGap5 = SizedBox(height: 5);
  static const Widget vGap8 = SizedBox(height: 8);
  static const Widget vGap10 = SizedBox(height: 10);
  static const Widget vGap12 = SizedBox(height: 12);
  static const Widget vGap15 = SizedBox(height: 15);
  static const Widget vGap16 = SizedBox(height: 16);
  static const Widget vGap24 = SizedBox(height: 24);
  static const Widget vGap32 = SizedBox(height: 32);
  static const Widget vGap50 = SizedBox(height: 50);

  static Widget line = const Divider();

  static Widget vLine =
      const SizedBox(width: 0.6, height: 24.0, child: VerticalDivider());

  static const Widget empty = SizedBox.shrink();
}
