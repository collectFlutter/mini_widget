import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';

class WidgetUtil {
  /// 获取图片宽高，加载错误情况返回 Rect.zero.（单位 px）
  static Future<Rect> getImageWH(
      {Image image, String url, String localUrl, String package}) {
    if (StringUtil.isEmpty(image) &&
        StringUtil.isEmpty(url) &&
        StringUtil.isEmpty(localUrl)) {
      return Future.value(Rect.zero);
    }
    Completer<Rect> completer = Completer<Rect>();
    Image img = image != null
        ? image
        : ((url != null && url.isNotEmpty)
            ? Image.network(url)
            : Image.asset(localUrl, package: package));
    img.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
          completer.complete(Rect.fromLTWH(
              0, 0, info.image.width.toDouble(), info.image.height.toDouble()));
        }, onError: (dynamic exception, StackTrace stackTrace) {
          completer.complete(Rect.zero);
        }));
    return completer.future;
  }
}
