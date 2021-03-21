library mini_widget;

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter/material.dart';

import 'global/mini_global.dart';

export 'bean/a.dart';
export 'bloc/bloc_provider.dart';
export 'cell/a.dart';
export 'delegate/a.dart';
export 'dialog/a.dart';
export 'enums/a.dart';
export 'page/a.dart';
export 'res/a.dart';
export 'util/a.dart';
export 'widget/a.dart';
export 'tools.dart';
export 'typedef.dart';

class MiniWidget {
  /// 初始化参数 <br/>
  /// [appName] - 应用名称 <br/>
  /// [appLogo] - 应用Logo,24×24<br/>
  /// [userName] - 用户名称 <br/>
  /// [amap] - 高德appkey <br/>
  static void init(String appName, Widget appLogo,
      {String userName, String amap}) {
    assert(appName != null && appLogo != null);
    miniGlobal = MiniGlobal(appName, userName, appLogo);
    AmapCore.init(amap);
  }
}
