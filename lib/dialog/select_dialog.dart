import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSimpleDialog(BuildContext context, List<String> item,
    {String title, ValueChanged<int> voidItemCallback}) {
  assert(item != null);
  int length = item.length;
  if (length < 1) return;
  List<CupertinoActionSheetAction> itemSheet = [];
  for (var i = 0; i < item.length; ++i) {
    itemSheet.add(CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
          if (voidItemCallback != null) {
            voidItemCallback(i);
          }
        },
        child: Text(item[i] ?? '')));
  }

  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text(title ?? ''),
          children: itemSheet,
        );
      });
}
