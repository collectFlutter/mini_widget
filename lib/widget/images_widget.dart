import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/dialog/bottom_dialog.dart';
import 'package:mini_widget/page/images_view_page.dart';
import 'package:mini_widget/res/a.dart';
import 'package:mini_widget/util/navigator_util.dart';

/// 标题 图片表格,支持编辑
class ImagesWidget extends StatelessWidget {
  final String label;
  final double labelWidth;
  final List<String> imgUrls;
  final EdgeInsetsGeometry padding;
  final bool isEdit;
  final ValueChanged<int> removeCallback;
  final ValueChanged<String> addCallback;
  final maxSize;
  final bool hasScrawl;
  final bool required;
  final VoidCallback onAddTap;

  /// 仅拍照
  final bool onlyCamera;

  ImagesWidget(this.imgUrls,
      {this.label,
      this.labelWidth = 80,
      this.maxSize = 4,
      this.hasScrawl = true,
      this.onlyCamera = false,
      this.padding = const EdgeInsets.all(1),
      this.isEdit = false,
      this.removeCallback,
      this.addCallback,
      this.required = false,
      this.onAddTap})
      : assert(imgUrls != null);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!StringUtil.isEmpty(label)) {
      List<Widget> items = [
        SizedBox(
            width: labelWidth,
            height: 40,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: MiniColor.gray, height: 1.1),
                  ),
                ),
                required
                    ? Icon(MdiIcons.multiplication, size: 8, color: Colors.red)
                    : Container(),
              ],
            )),
        Wrap(alignment: WrapAlignment.start, children: _buildItem(context))
      ];
      child = maxSize > 3
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: items)
          : Row(children: items);
    } else {
      child =
          Wrap(alignment: WrapAlignment.start, children: _buildItem(context));
    }

    return Container(
        padding: padding, alignment: Alignment.topLeft, child: child);
  }

  _buildItem(BuildContext context) {
    List<Widget> _temp = [];
    bool showRemove = this.isEdit && this.removeCallback != null;

    for (int i = 0; i < this.imgUrls.length; i++) {
      String url = this.imgUrls[i];
      _temp.add(
        Material(
          color: Colors.transparent,
          child: Ink(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                MiniNavigatorUtil.pushPage(
                    context,
                    ImagesViewPage(
                        imgUrls: imgUrls,
                        defaultIndex: i,
                        width: MediaQuery.of(context).size.width));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 2, top: showRemove ? 12 : 2, bottom: 2),
                    width: showRemove ? 70 : 80,
                    height: showRemove ? 70 : 80,
                    child: UrlUtil.isUrl(url)
                        ? Image.network(
                            url ?? '',
                            errorBuilder: (ctx, _, __) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          )
                        : Image.file(File(url), fit: BoxFit.cover),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: 80,
                    height: 80,
                    child: showRemove
                        ? GestureDetector(
                            child: Icon(
                              MdiIcons.closeCircle,
                              color: MiniColor.deepPink,
                            ),
                            onTap: () => removeCallback(i),
                          )
                        : Text(""),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (this.isEdit &&
        (this.addCallback != null || this.onAddTap != null) &&
        this.maxSize > this.imgUrls.length) {
      _temp.add(
        Material(
          color: Colors.transparent,
          child: Ink(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (this.onAddTap != null) {
                  this.onAddTap();
                  return;
                }
                if (onlyCamera) {
                  MiniNavigatorUtil.cameraImageAndScrawl(context,
                          hasScrawl: hasScrawl)
                      .then((path) {
                    if (path != null) addCallback(path);
                  });
                } else {
                  showBottomPopup(context, '选择操作方式', ['拍照', '选照片'])
                      .then((index) {
                    if (index == 0) {
                      MiniNavigatorUtil.cameraImageAndScrawl(context,
                              hasScrawl: hasScrawl)
                          .then((path) {
                        if (path != null) addCallback(path);
                      });
                    } else if (index == 1) {
                      MiniNavigatorUtil.getImageAndScrawl(context,
                              hasScrawl: hasScrawl)
                          .then((path) {
                        if (path != null) addCallback(path);
                      });
                    }
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 2, top: 2, bottom: 2),
                padding: EdgeInsets.all(5),
                width: 80,
                height: 80,
                child: Icon(MdiIcons.imageSearchOutline,
                    size: 70, color: Colors.grey[200]),
              ),
            ),
          ),
        ),
      );
    }
    return _temp;
  }
}
