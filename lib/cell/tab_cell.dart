import 'package:flutter/material.dart';
import 'package:mini_widget/res/a.dart';

/// 表头
Widget buildTabHeader(List<String> titles,
    {List<int> flex,
    List<Color> colors,
    List<Alignment> alignments,
    List<TextStyle> textStyles,
    Color color,
    TextStyle textStyle,
    double height = 40,
    bool action = false,
    Widget actionChild,
    double actionWidth = 80}) {
  assert(flex == null || titles.length == flex.length);
  assert(alignments == null || titles.length == alignments.length);
  assert(textStyles == null || titles.length == textStyles.length);
  List<Widget> items = [];

  for (var i = 0; i < titles.length; ++i) {
    var title = titles[i];
    Alignment _alignment =
        alignments != null ? alignments[i] : Alignment.center;
    TextStyle _style = textStyles != null
        ? textStyles[i]
        : (textStyle ??
            MiniStyle.textTag.copyWith(
              color: colors == null ? Colors.white : colors[i] ?? Colors.white,
            ));
    int _flex = flex != null ? flex[i] : 1;
    items.add(
      Expanded(
        flex: _flex,
        child:
            Container(alignment: _alignment, child: Text(title, style: _style)),
      ),
    );
  }
  if (action) {
    items.add(Container(
      width: actionWidth,
      alignment: Alignment.center,
      child: actionChild ??
          Text('操作',
              style:
                  textStyle ?? MiniStyle.textTag.copyWith(color: Colors.white)),
    ));
  }

  return Container(
    color: color ?? MiniColor.primary,
    height: height,
    alignment: Alignment.center,
    child: Flex(direction: Axis.horizontal, children: items),
  );
}

/// 表行
Widget buildTabRow(
  List<String> values, {
  List<int> flex,
  List<Color> colors,
  List<Alignment> alignments,
  List<TextStyle> textStyles,
  Color color,
  TextStyle textStyle,
  GestureTapCallback onTap,
  double height = 45,
  bool action = false,
  double actionWidth = 80,
  Widget actionChild,
}) {
  assert(flex == null || values.length == flex.length);
  assert(alignments == null || values.length == alignments.length);
  assert(textStyles == null || values.length == textStyles.length);
  List<Widget> items = [];
  for (var i = 0; i < values.length; ++i) {
    var value = values[i];
    Alignment _alignment =
        alignments != null ? alignments[i] : Alignment.center;
    TextStyle _style = textStyles != null
        ? textStyles[i]
        : (textStyle ??
            MiniStyle.textDarkNormal.copyWith(
                fontSize: MiniDimen.fontSmall,
                color: colors == null
                    ? MiniColor.textDark
                    : colors[i] ?? MiniColor.textDark));
    int _flex = flex != null ? flex[i] : 1;
    items.add(
      Expanded(
        flex: _flex,
        child: Container(
            alignment: _alignment, child: Text(value ?? '', style: _style)),
      ),
    );
  }
  if (action) {
    items.add(Container(
      width: actionWidth,
      alignment: Alignment.center,
      child: Center(child: actionChild ?? Container()),
    ));
  }
  return Material(
    child: Ink(
      color: color ?? Colors.blue[50],
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          alignment: Alignment.centerLeft,
          child: Flex(
            direction: Axis.horizontal,
            children: items,
          ),
        ),
      ),
    ),
  );
}

/// 长表头
Widget buildLongTabHeader(List<String> titles,
    {ScrollController controller,
    double width = 80,
    double height = 30,
    Color color,
    TextStyle textStyle}) {
  if (width <= 80 && titles.length < 6) {
    return buildTabHeader(titles, color: color, textStyle: textStyle);
  }
  List<Widget> items = [];

  for (var i = 0; i < titles.length; ++i) {
    var title = titles[i];
    items.add(Container(
        width: width,
        alignment: Alignment.center,
        child: Text(title,
            style: textStyle ??
                MiniStyle.textTag.copyWith(color: MiniColor.white))));
  }
  return SingleChildScrollView(
    controller: controller,
    scrollDirection: Axis.horizontal,
    child: Container(
        color: color ?? MiniColor.primary,
        height: height,
        child: Row(
          children: items,
        )),
  );
}

/// 长表行
Widget buildLongTabRow(List<String> values,
    {ScrollController controller,
    double width = 80,
    Color color,
    TextStyle textStyle,
    GestureTapCallback onTap}) {
  if (width <= 80 && values.length < 6) {
    return buildTabRow(values, color: color, textStyle: textStyle);
  }
  List<Widget> items = [];
  for (var i = 0; i < values.length; ++i) {
    var value = values[i];
    items.add(Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, right: 3, left: 3),
        width: width,
        alignment: Alignment.center,
        child: Text(value ?? '',
            style: textStyle ??
                MiniStyle.textDarkNormal
                    .copyWith(fontSize: MiniDimen.fontSmall))));
  }
  return Material(
    child: Ink(
      color: color ?? Colors.blue[50],
      child: InkWell(
        onTap: onTap,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: Container(
              alignment: Alignment.centerLeft, child: Row(children: items)),
        ),
      ),
    ),
  );
}
