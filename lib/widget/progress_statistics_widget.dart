import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';

/// 进度统计组件
class ProgressStatisticsWidget extends StatelessWidget {
  /// 标签名称
  final String label;

  /// 进度颜色
  final Color color;

  /// 最大值（不可为0）
  final num max;

  /// 当前值（不可大于[max])
  final num value;

  /// 右侧标签自定义组件
  final Widget tagWidget;

  /// 右侧标签宽度
  final double labelWidth;

  /// 进度条总宽度
  final double statisticsWidth;

  /// 进度条总高度
  final double statisticsHeight;

  const ProgressStatisticsWidget({
    Key key,
    this.label,
    this.color = Colors.blue,
    this.max = 1,
    this.value = 0,
    this.tagWidget,
    this.labelWidth = 80,
    this.statisticsHeight = 6,
    this.statisticsWidth = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    Color childColor = this.color;
    double valueWidth = statisticsWidth;

    num total = this.max ?? 0.0;
    if (total == 0.0) {
      total = this.value;
    } else {
      valueWidth = statisticsWidth * this.value / total;
    }

    if (this.tagWidget != null) {
      child = this.tagWidget;
    } else if (this.value == total) {
      childColor = Colors.green;
      child = Icon(Icons.check_circle, color: childColor, size: 16);
    } else {
      child = Text(
        "${NumUtil.getNumByValueDouble(this.value * 100.0 / total, 0)}%",
        style: MiniStyle.textTag.copyWith(color: Colors.black),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        this.label == null
            ? Container()
            : Text(label,
                style: MiniStyle.textTag.copyWith(color: Colors.black)),
        Container(
          height: 20,
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      width: statisticsWidth,
                      height: statisticsHeight,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      )),
                  Container(
                      width: valueWidth,
                      height: statisticsHeight,
                      decoration: BoxDecoration(
                        color: childColor,
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      )),
                ],
              ),
              SizedBox(width: 10),
              child
            ],
          ),
        )
      ],
    );
  }
}
