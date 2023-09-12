import 'package:flutter/material.dart';

import 'height_key_widget.dart';

class LineCell extends StatelessWidget {
  final String? title;
  final Color? color;
  final Widget? titleChild;
  final Widget? leading;
  final IconData? iconData;
  final Color? iconColor;
  final String? iconPath;
  final String? subLabel;
  final Widget? subLabelChild;
  final bool showNext;
  final TextStyle? titleStyle;
  final TextStyle? subLabelStyle;
  final bool? showLine;
  final double? height;
  final String? heightKey;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;

  const LineCell({
    Key? key,
    this.title,
    this.titleChild,
    this.iconData,
    this.subLabel,
    this.showNext = true,
    this.titleStyle,
    this.subLabelStyle,
    this.showLine = true,
    this.onTap,
    this.onLongPress,
    this.iconPath,
    this.color,
    this.subLabelChild,
    this.leading,
    this.height = 55,
    this.heightKey,
    this.iconColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 25),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Container();
    if (leading != null) {
      iconWidget = leading!;
    } else if (iconData != null) {
      iconWidget = Icon(iconData, color: iconColor, size: 18);
    } else if (iconPath != null && iconPath!.isNotEmpty) {
      iconWidget = Image.asset(iconPath!);
    }
    return Material(
      color: color ?? Theme.of(context).canvasColor,
      child: Ink(
        color: color ?? Theme.of(context).canvasColor,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Column(
            children: <Widget>[
              Container(
                height: height,
                padding: padding,
                child: Row(
                  children: <Widget>[
                    iconWidget,
                    const SizedBox(width: 15),
                    Expanded(
                      child: titleChild ??
                          HeightKeyWidget(
                            content: title ?? '',
                            textStyle: titleStyle ??
                                Theme.of(context).textTheme.bodyMedium,
                            heightKey: heightKey,
                            makLines: 1,
                          ),
                    ),
                    subLabelChild ??
                        Text(
                          subLabel ?? '',
                          style: subLabelStyle ??
                              Theme.of(context).textTheme.bodyMedium,
                        ),
                    showNext
                        ? const Icon(Icons.navigate_next,
                            color: Color(0xff8c95ac))
                        : Container()
                  ],
                ),
              ),
              Container(
                height: showLine == true ? 0.5 : 0.0,
                color: Theme.of(context).dividerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
