import 'package:flutter/material.dart';
import 'package:mini_widget/bean/edit_value_model.dart';
import 'package:mini_widget/bean/tag_value_model.dart';
import '../res/a.dart';
import 'edit_cell.dart';
import 'package:mini_tools/mini_tools.dart';

import 'text_cell.dart';

/// 抬头
Widget buildHeaderCell(
    {String imagePath,
    Widget ledging,
    String title = '',
    String title2 = '',
    TextStyle textStyle,
    TextStyle textStyle2,
    EdgeInsetsGeometry padding,
    BuildContext context,
    VoidCallback onMoreTop,
    VoidCallback onMoreLongPress}) {
  textStyle = textStyle != null
      ? textStyle
      : TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  textStyle2 = textStyle2 != null
      ? textStyle2
      : onMoreTop == null
          ? MiniStyle.textNormal
          : MiniStyle.textUrl;
  return Padding(
    padding: padding ?? EdgeInsets.all(10),
    child: Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          width: 30,
          alignment: Alignment.centerLeft,
          child: ledging ??
              (imagePath != null
                  ? UrlUtil.isUrl(imagePath)
                      ? Image.network(imagePath, height: 20, width: 20)
                      : Image.asset(imagePath, height: 20, width: 20)
                  : Container()),
        ),
        Container(
            padding: EdgeInsets.only(
                left: (imagePath == null && ledging == null) ? 0 : 30),
            alignment: Alignment.centerLeft,
            child: Text(title ?? '',
                style: textStyle, overflow: TextOverflow.ellipsis)),
        Container(
          padding: EdgeInsets.only(left: 5),
          alignment: Alignment.centerRight,
          child: Container(
            width: 200,
            alignment: Alignment.bottomRight,
            child: GestureDetector(
                child: Text(
                  title2 ?? '',
                  style: textStyle2,
                  overflow: TextOverflow.ellipsis,
                ),
                onLongPress: onMoreLongPress,
                onTap: onMoreTop),
          ),
        ),
      ],
    ),
  );
}

/// 列表带更多抬头
Widget buildListMoreCell(
    {String title,
    int allSize = 0,
    int size = -1,
    VoidCallback onMoreTop,
    VoidCallback onLongPress,
    String moreText = '更多   '}) {
  return Padding(
    padding: EdgeInsets.only(left: 18, top: 8, bottom: 5, right: 10),
    child: Row(children: <Widget>[
      Expanded(
        child: Text.rich(
          TextSpan(children: [
            TextSpan(text: '$title (', style: MiniStyle.textTitle),
            TextSpan(
                text: '$allSize',
                style: MiniStyle.textTitle.copyWith(color: MiniColor.deepPink)),
            TextSpan(text: ')', style: MiniStyle.textTitle),
          ]),
        ),
      ),
      GestureDetector(
        child: Text((allSize > size && size > -1) ? moreText : '',
            style: MiniStyle.textUrl),
        onTap: onMoreTop,
        onLongPress: onLongPress,
      ),
    ]),
  );
}

/// 构建头部+卡片
Widget buildHeadCardCell(
    {String headText,
    String rightHeadText,
    TextStyle headTextStyle,
    TextStyle rightHeadTextStyle,
    BuildContext context,
    Widget headChild,
    Widget child,
    List values,
    Color color = Colors.white,
    double tagWidth = 70,
    double miniHeight = 30,
    double fontSize,
    EdgeInsetsGeometry valuePadding = const EdgeInsets.all(1),
    EdgeInsetsGeometry childPadding = const EdgeInsets.all(5),
    double paddingRight = 0.0,
    VoidCallback onMoreTop,
    VoidCallback onMoreLongPress}) {
  if (values == null) values = [];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      headChild ??
          buildHeaderCell(
              title: headText ?? '',
              title2: rightHeadText ?? '',
              onMoreLongPress: onMoreLongPress,
              textStyle: headTextStyle,
              textStyle2: rightHeadTextStyle,
              onMoreTop: onMoreTop),
      Container(
        color: color,
        width: double.infinity,
        padding: childPadding,
        child: child ??
            Column(
              children: values.map((data) {
                if (data is TagValueModel) {
                  return buildTextCell(
                      data: data,
                      fontSize: fontSize,
                      padding: valuePadding,
                      paddingRight: paddingRight,
                      tagWidth: tagWidth,
                      miniHeight: miniHeight,
                      context: context);
                }
                if (data is EditValueModel) {
                  data.tagWidth = tagWidth;
                  return Container(
                      child: buildEditCell(
                          data: data,
                          minHeight: miniHeight,
                          padding: valuePadding));
                }
                if (data is Widget) {
                  return data;
                }
                return Container();
              }).toList(),
            ),
      ),
    ],
  );
}
