import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/a.dart';
import 'package:mini_widget/res/colors.dart';
import 'package:mini_widget/widget/a.dart';

Widget buildLineCell(
    {String title,
    Widget titleChild,
    Icon icon,
    String svgName,
    String iconName,
    String numString,
    bool showNext = true,
    Color color = Colors.white,
    Color titleColor = Colors.black,
    bool showLine = false,
    VoidCallback onPressed}) {
  Widget iconWidget = icon == null
      ? (iconName == null
          ? (SvgPicture.asset(
              svgName,
              width: 24,
              height: 24,
            ))
          : Image.asset(iconName))
      : icon;

  return Material(
    color: color,
    child: Ink(
      color: color,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    iconWidget,
                    SizedBox(width: 20),
                    Expanded(
                      child: titleChild ??
                          Text(
                            title,
                            style: TextStyle(fontSize: 18, color: titleColor),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                    ),
                    numString == null ? Container() : Text(numString),
                    Icon(showNext ? Icons.navigate_next : null),
                  ],
                ),
              ),
              Container(
                height: showLine == true ? 1 : 0.0,
                color: MiniColor.lightGray,
                margin: EdgeInsets.only(left: 60),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildErrorLineCell(
    {String errorText,
    IconData errorIcon = Icons.error,
    Color errorColor = Colors.red,
    double height = 40,
    Color backgroundColor = Colors.white}) {
  return Container(
    height: height,
    color: backgroundColor,
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(errorIcon, color: errorColor),
        SizedBox(width: 5),
        Text(errorText ?? '', style: TextStyle(color: errorColor))
      ],
    ),
  );
}

/// Icon + Text 横向显示
Widget buildIconLineCell({
  Icon icon,
  String label,
  Color labelColor,
  Color valueColor,
  VoidCallback voidCallback,
}) {
  return Ink(
    child: InkWell(
      onTap: voidCallback,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: valueColor ?? MiniColor.black),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget build2LineCell(
    {String label,
    Color labelColor = MiniColor.black,
    String smallLabel,
    Color smallColor = MiniColor.black,
    String value,
    Color valueColor = MiniColor.black,
    VoidCallback voidCallback}) {
  return Ink(
    child: InkWell(
      onTap: voidCallback,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  value,
                  style: TextStyle(
                      color: valueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  smallLabel ?? '',
                  style: TextStyle(color: smallColor, fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(color: labelColor, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildTimeLineCell(
    {String dealTime = '',
    String dealMan = '',
    String headUrl = '',
    Widget headDefault,
    String title = '',
    String memo = '',
    String circularLabel = '',
    Color circularColor = Colors.blue,
    bool isState = false,
    bool isEnd = false}) {
  return Material(
    child: Ink(
      child: InkWell(
        child: Container(
          color: MiniColor.white,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Container(
                height: 100,
                width: 80,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Text(dealTime.getTimeStr(), style: MiniStyle.textTitle),
                    SizedBox(height: 5),
                    Text(dealTime.getDateStr(), style: MiniStyle.textTag),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 15,
                              width: 2,
                              color:
                                  isState ? Colors.transparent : Colors.blue),
                          Container(
                              height: 85,
                              width: 2,
                              color: isEnd ? Colors.transparent : Colors.blue),
                        ],
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: circularColor, width: 1.0),
                          color: circularColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      margin: EdgeInsets.only(top: 2),
                      alignment: Alignment.center,
                      child: UrlUtil.isUrl(headUrl)
                          ? NetworkImage(headUrl)
                          : Text(circularLabel ?? '',
                              style: MiniStyle.textTag
                                  .copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 10, right: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        BorderWidget(label: title, fontSize: 13)
                      ]),
                      SizedBox(height: 5),
                      Text('$dealMan',
                          style: TextStyle(
                              fontSize: MiniDimen.fontSmall,
                              height: 1.1,
                              color: MiniColor.gray)),
                      Expanded(
                          child: Text(memo,
                              style: TextStyle(
                                  fontSize: MiniDimen.fontSmall,
                                  height: 1.1,
                                  color: MiniColor.gray))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

/// 带点击事件
//Widget buildLineTagCell(
//  String tag,
//  String value, {
//  EdgeInsetsGeometry padding = const EdgeInsets.all(1),
//  bool showLine = false,
//  Color color = Colors.white,
//  Color tagColor = MiniColor.gray,
//  Color valueColor = Colors.black,
//  VoidCallback onPressed,
//}) {
//  return Material(
//    color: color,
//    child: Ink(
//      child: InkWell(
//        onTap: onPressed,
//        child: Column(children: <Widget>[
//          Padding(
//            padding: padding,
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SizedBox(
//                    width: 80,
//                    child: Text(
//                      tag,
//                      overflow: TextOverflow.ellipsis,
//                      maxLines: 1,
//                      style: TextStyle(color: tagColor, height: 1.1),
//                    )),
//                Expanded(
//                  child: Text(
//                    value,
//                    style: TextStyle(height: 1.1, color: valueColor),
//                  ),
//                ),
//                onPressed == null ? Container() : Icon(Icons.navigate_next),
//              ],
//            ),
//          ),
//          showLine ? Divider() : Container(),
//        ]),
//      ),
//    ),
//  );
//}
