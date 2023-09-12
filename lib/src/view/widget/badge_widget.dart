import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final int count;
  final bool flag;
  final double fontSize;

  const BadgeWidget(
      {Key? key, this.count = 0, this.flag = false, this.fontSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(18.0),
        ),
      ),
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Text(
        flag ? '!' : (count > 99 ? '99+' : '$count'),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
