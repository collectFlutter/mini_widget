import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url;

import 'application.dart';
import 'pop_param.dart';

class NavigatorUtil {
  static Future<PopParam> pushRouter(
    BuildContext context,
    String path, {
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.inFromBottom,
    Map<String, dynamic> params = const {},
  }) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (params.isNotEmpty) {
      StringBuffer str = StringBuffer();
      params.forEach((key, value) {
        str
          ..write("&")
          ..write(key)
          ..write('=')
          ..write(value is String ? Uri.encodeComponent(value) : value);
      });
      path = "$path?${str.toString().substring(1)}";
    }

    var result = await Application.router?.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      transitionDuration: const Duration(milliseconds: 300),
    );
    if (result != null && result is PopParam) return result;
    return PopParam(false, null);
  }

  static Future<PopParam> push(BuildContext context, Widget page) async {
    FocusScope.of(context).requestFocus(FocusNode());
    var result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (ctx, animation, secondaryAnimation) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: page,
        ),
      ),
    );
    if (result != null && result is PopParam) return result;
    return PopParam(false, null);
  }

  static void pop(BuildContext context, {bool? success, dynamic data}) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (Navigator.canPop(context)) {
      if (success == null) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context, PopParam(success, data));
      }
    }
  }

  /// 拨打号码
  static void launchTel(String tel) => url.launchUrl(Uri(path: "tel:$tel"));

  static void launchUrl(String path) => url.launchUrl(Uri(path: path));

  ///  发送邮件
  static void launchMail(String email) =>
      url.launchUrl(Uri(path: "mailto:$email"));
}
