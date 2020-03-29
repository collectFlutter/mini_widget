


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mini_tools/mini_tools.dart';
import '../page/webview_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MiniNavigatorUtil {
  static Future<dynamic> pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null) return null;
    return Navigator.push(context, new CupertinoPageRoute(builder: (ctx) => page));
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget page) {
    return Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => page));
  }

  static void pushWeb(BuildContext context, {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || StringUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
        context,
        new CupertinoPageRoute<void>(
          builder: (ctx) => WebViewPage(
                title: title,
                titleId: titleId,
                url: url,
              ),
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
}
