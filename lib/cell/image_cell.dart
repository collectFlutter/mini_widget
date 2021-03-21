// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/bean/image_label_model.dart';
import 'package:mini_widget/res/colors.dart';
import 'package:mini_widget/res/dimens.dart';

/// 带圆角的图片显示
Widget buildImageCell(
    {String path,
    BorderRadius borderRadius,
    double width = double.infinity,
    double height = 150,
    double radius = 5,
    Widget placeholder,
    Widget errorWidget}) {
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
    child: StringUtil.isEmpty(path)
        ? errorWidget
        : UrlUtil.isUrl(path)
            ? Image.network(
                path ?? '',
                errorBuilder: (ctx, _, __) => errorWidget,
                loadingBuilder: (ctx, _, __) => placeholder,
                width: width,
                height: height,
                fit: BoxFit.cover,
              )
            : Image.asset(path,
                width: width, height: height, fit: BoxFit.cover),
  );
}

Widget buildImageLabelCell(ImageLabelModel _model, [VoidCallback _callback]) {
  return Material(
    child: Ink(
      color: MiniColor.white,
      child: InkWell(
        onTap: _callback,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 24,
                height: 24,
                child: _model.getImage(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _model.getLabel(),
                style: TextStyle(fontSize: MiniDimen.fontMini),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
