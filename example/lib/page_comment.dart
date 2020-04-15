import 'package:flutter/cupertino.dart';
import 'package:mini_widget/mini_widget.dart';
import 'page/form_demo_page.dart';
import 'page/segmented_demo_page.dart';

var pages = [
  {
    'label': '首次启动',
    'page': SplashPage(
      firstImgUrl: [
        'assets/splash/app_start_1.png',
        'assets/splash/app_start_2.png',
        'assets/splash/app_start_3.png',
        'assets/splash/app_start_4.png',
      ],
      splashImgUrl: 'assets/splash/first.png',
      endCallback: (ctx) {
        Navigator.pop(ctx);
      },
    ),
  },
  {
    'label': '首屏页面',
    'page': SplashPage(
      splashImgUrl: 'assets/splash/first.png',
      showFirst: false,
      endCallback: (ctx) {
        Navigator.pop(ctx);
      },
    ),
  },
  {'label': '水平分段', 'page': SegmentedDemoPage()},
  {'label': '表单页面', 'page': FormDemoPage()},
];
