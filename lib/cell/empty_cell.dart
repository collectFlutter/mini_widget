import 'package:flutter/material.dart';

import '../mini_widget.dart';

/// 空视图
Widget buildEmptyWidget({Widget child,String emptyImageAsset,String emptyMessage = '暂无内容！'}) {
  return ListView.builder(
    itemCount: 1,
    itemBuilder: (ctx, index) =>
        child ??
        Container(
          width: double.infinity,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/empty_icon.png', width: 100, height: 100),
              SizedBox(height: 10),
              Text('暂无内容！', style: MiniStyle.textNormal),
            ],
          ),
        ),
  );
}
