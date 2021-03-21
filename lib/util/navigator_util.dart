import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_widget/global/mini_global.dart';
import 'package:mini_widget/mini_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mini_tools/mini_tools.dart';

import 'dart:async';

import '../dialog/loading_dialog.dart';
import '../page/webview_page.dart';
import '../page/scrawl_Location_page.dart';
import 'widget_util.dart';

class MiniNavigatorUtil {
  static Future<dynamic> pushPage(BuildContext context, Widget page,
      {String pageName}) async {
    assert(context != null && page != null);
    FocusScope.of(context).requestFocus(FocusNode());
    var result = await Navigator.push(
        context, CupertinoPageRoute(builder: (ctx) => page));
    return result;
  }

  static void pop(BuildContext context, {bool success}) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (Navigator.canPop(context)) {
      if (success == null) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context, success);
      }
    }
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget page) {
    return Navigator.of(context)
        .pushReplacement(CupertinoPageRoute(builder: (ctx) => page));
  }

  static void pushWeb(BuildContext context,
      {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || StringUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
        context,
        new CupertinoPageRoute<void>(
          builder: (ctx) =>
              WebViewPage(title: title, titleId: titleId, url: url),
        ),
      );
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// 选择后涂鸦
  static Future<String> getImageAndScrawl(BuildContext context,
      {bool hasScrawl = true}) async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return null;
    showLoadingDialog(context);
    File compressFile1 = await FileUtil.compressWithFile(image.path);
    Rect rect = await WidgetUtil.getImageWH(localUrl: compressFile1.path);
    double w = rect.width;
    double h = rect.height;
    File compressFile =
        await FileUtil.compressWithFile(image.path, rotate: w > h ? 90 : 0);
    Navigator.pop(context);
    if (!hasScrawl) return compressFile.path;

    /// 进行图片涂鸦
    return await getScrawlImage(context, imagePath: compressFile.path);
  }

  /// 拍照+涂鸦(位置信息)
  static Future<String> cameraImageAndScrawl(BuildContext context,
      {bool hasScrawl = true,
      String appName,
      String authorName,
      Widget appLogo}) async {
    if (await Permission.camera.request().isGranted) {
      var image = await ImagePicker().getImage(source: ImageSource.camera);
      if (image == null) return null;
      showLoadingDialog(context);
      print('图片路径${image.path}');
      File compressFile1 = await FileUtil.compressWithFile(image.path);
      Rect rect = await WidgetUtil.getImageWH(localUrl: compressFile1.path);
      double w = rect.width;
      double h = rect.height;
      File compressFile =
          await FileUtil.compressWithFile(image.path, rotate: w > h ? 90 : 0);
      print('压缩后路径：${compressFile.path}');
      Navigator.pop(context);
      if (!hasScrawl) return compressFile.path;
      // await Permission.location.request();
      return await getScrawlImage(context, imagePath: compressFile.path);
    }
    return null;
  }

  static Future<String> getScrawlImage(BuildContext context,
      {String imagePath,
      List<Color> colors = const [Colors.redAccent, Colors.lightBlueAccent],
      bool enableTransform = true,
      backColor = Colors.black12}) async {
    var scrawlImage = await pushPage(
        context,
        ScrawlWithLocationPage(imagePath,
            colors: colors,
            enableTransform: enableTransform,
            backColor: backColor,
            appName: miniGlobal?.appName,
            authorName: miniGlobal?.userName,
            appLogo: miniGlobal?.appLogo));
    print("文件路径：$scrawlImage");
    return scrawlImage;
  }
}
