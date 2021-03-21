import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_widget/bean/image_label_model.dart';
import 'package:mini_widget/mini_widget.dart';

import '../typedef.dart';

void showBottomSheetGridMenu(
  BuildContext context,
  List<ImageLabelModel> item, {
  String title,
  ValueChanged<ImageLabelModel> itemCallback,
}) {
  assert(item != null);
  int _length = item.length;
  if (_length < 1) return;
  int _row = 4;
  double _height;

  if (_length < 4) {
    _row = _length;
    if (_length == 3) {
      _height = 110;
    } else if (_length == 2) {
      _height = 120;
    } else {
      _height = 150;
    }
  } else if (_length < 5) {
    _height = 110.0;
  } else if (_length < 9) {
    _height = 190.0;
  } else if (_length < 13) {
    _height = 270.0;
  } else if (_length < 17) {
    _height = 350.0;
  } else {
    _height = 500.0;
  }

  Widget menu = Container(
    color: MiniColor.white,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: _height,
        child: GridView.builder(
          itemCount: _length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _row,
            childAspectRatio: _row == 1
                ? 2.5
                : _row == 2
                    ? 1.5
                    : 1.0,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (ctx, index) {
            return buildImageLabelCell(item[index], () {
              Navigator.of(ctx).pop();
              if (itemCallback != null) {
                itemCallback(item[index]);
              }
            });
          },
        ),
      ),
    ),
  );

  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return menu;
      });
}

Future<int> showBottomPopup<T>(BuildContext context, String title, List<T> item,
    {String message, BuildCheckChild<T> buildCheckChild}) async {
  final ThemeData theme = Theme.of(context);
  final TextStyle dialogTextStyle =
      theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);
  List<CupertinoActionSheetAction> itemSheet = [];
  for (var i = 0; i < item.length; ++i) {
    itemSheet.add(
      CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context, i),
        child: buildCheckChild != null
            ? buildCheckChild(context, item[i])
            : Text('${item[i]}', style: TextStyle(fontSize: 14)),
      ),
    );
  }
  return await showCupertinoModalPopup<int>(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text(title ?? '请选择'),
      message: message == null ? null : Text(message, style: dialogTextStyle),
      actions: itemSheet,
      cancelButton: CupertinoActionSheetAction(
        child: const Text('取消'),
        isDefaultAction: true,
        onPressed: () => Navigator.pop(context),
      ),
    ),
  );
}

void showBottomDialog(BuildContext context, Widget child,
    {bool barrierDismissible = true}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => WillPopScope(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (barrierDismissible) Navigator.pop(context);
                      },
                      child: Container(color: MiniColor.black8a),
                    ),
                  ),
                  Material(child: child, color: MiniColor.black8a)
                ],
              ),
            ),
            onWillPop: () async {
              return Future.value(barrierDismissible);
            },
          ));
}
