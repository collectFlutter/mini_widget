import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void showImageDialog(BuildContext context, String imgUrl, {String label = ""}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => CupertinoAlertDialog(
      title: Text(label),
      content: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: imgUrl,
            width: 250,
            height: 250,
            errorWidget: (ctx, url, _) => Icon(Icons.error, color: Colors.red),
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("确定"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}

void showQrImageDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (ctx) => CupertinoAlertDialog(
      content: SizedBox(
        width: 250,
        height: 250,
        child: QrImage(data: content, size: 400),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("返回"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
