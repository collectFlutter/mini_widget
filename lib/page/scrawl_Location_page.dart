import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:mini_tools/mini_tools.dart';
import '../dialog/loading_dialog.dart';
import '../res/a.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:io';

import '../painter/scrawl_painter.dart';
import '../tools.dart';
import 'base/mini_state.dart';
import 'base/mixin_state.dart';

/// 图片涂鸦+显示地理位置, 返回保存后的图片路径
class ScrawlWithLocationPage extends StatefulWidget {
  final String appName;
  final String filePath;
  final List<Color> colors;
  final Color backColor;
  final bool showTop;
  final bool showLocal;
  final bool enableTransform;
  final Widget appLogo;
  final String authorName;

  ScrawlWithLocationPage(this.filePath,
      {this.colors = const [Colors.redAccent, Colors.lightBlueAccent],
      this.backColor = Colors.black12,
      this.appLogo,
      this.showTop = true,
      this.showLocal = true,
      this.enableTransform = true,
      this.appName = '',
      this.authorName = ''});

  @override
  State<StatefulWidget> createState() => _ScrawlWithLocationState();
}

class _ScrawlWithLocationState extends State<ScrawlWithLocationPage>
    with StateMixin {
  double rotateX = 0;
  double scale = 1;
  String location = '';
  static final List<double> lineWidths = [5.0, 8.0, 10.0];
  File imageFile;
  int selectedLine = 0;
  Color selectedColor;
  List<PaintModel> paints;

  final GlobalKey _repaintKey = new GlobalKey();

  double get strokeWidth => lineWidths[selectedLine];

  @override
  void initState() {
    super.initState();
    selectedColor = widget.colors[0];
    paints = [
      PaintModel(
          sPoint: [], strokeColor: selectedColor, strokeWidth: strokeWidth)
    ];
    imageFile =
        StringUtil.isEmpty(widget.filePath) ? null : File(widget.filePath);
    if (widget.showLocal) {
      _checkPermission();
    }
  }

  void _checkPermission() async {
    await Permission.location.request();
    AmapLocation.listenLocation(needAddress: true).listen((value) async {
      String address = value.address;
      location = address ?? "";
      setState(() {});
    });
  }

  @override
  void dispose() {
    //注意这里关闭
    if (widget.showLocal) {
      AmapLocation.stopLocation();
      AmapLocation.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidthDp = MediaQuery.of(context).size.width;
    final double screenHeightDp = MediaQuery.of(context).size.height;
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.black,
                  child: RepaintBoundary(
                    key: _repaintKey,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            color: Colors.black,
                            child: Transform.scale(
                              scale: scale,
                              child: Transform(
                                transform: Matrix4.identity()..rotateZ(rotateX),
                                origin: Offset(
                                    screenWidthDp / 2, screenHeightDp / 2),
                                child: imageFile == null
                                    ? Container()
                                    : Image.file(imageFile,
                                        fit: BoxFit.fitWidth,
                                        width: screenWidthDp,
                                        height: screenHeightDp),
                              ),
                            )),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                              alignment: Alignment.center,
                              color: widget.backColor),
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: _buildCanvas(),
                        ),
                        Positioned(
                          bottom: 15.0,
                          right: 10.0,
                          child: widget.showLocal ? _buildLocal() : Container(),
                        ),
                        Positioned(
                          top: 30.0,
                          left: 15.0,
                          child: widget.showTop ? _buildTop() : Container(),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: _buildCanvasTool(screenHeightDp),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: widget.enableTransform
                      ? _buildTransformTool(screenHeightDp)
                      : Container(),
                )
              ],
            ),
          ),
        ),
        onWillPop: onSystemBack);
  }

  Widget _buildTop() {
    return Container(
      width: 200,
      child: Row(children: <Widget>[
        Container(
            width: 2,
            height: 70,
            color: Colors.white,
            alignment: Alignment.center),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateUtil.getDateStrByDateTime(DateTime.now(),
                    format: DateFormat.HOUR_MINUTE),
                style: MiniStyle.textTitle
                    .copyWith(color: Colors.white, fontSize: 24),
              ),
              Text(
                "${DateUtil.getDateStrByDateTime(DateTime.now(), format: DateFormat.YEAR_MONTH_DAY)}  ${DateUtil.getZHWeekDay(DateTime.now())}",
                style: MiniStyle.textNormal.copyWith(color: Colors.white),
              ),
              Row(
                children: <Widget>[
                  Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(5),
                      child: widget.appLogo),
                  Text(widget.appName,
                      style: MiniStyle.textTag
                          .copyWith(color: MiniColor.lightGray)),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildLocal() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.person, color: Colors.white, size: 16),
              Text(widget.authorName,
                  softWrap: true,
                  maxLines: 2,
                  style: MiniStyle.textTag.copyWith(color: Colors.white))
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 16),
              Text(location,
                  softWrap: true,
                  maxLines: 2,
                  style: MiniStyle.textTag.copyWith(color: Colors.white))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCanvas() {
    return StatefulBuilder(builder: (context, state) {
      return CustomPaint(
        painter: ScrawlPainter(paints: paints),
        child: GestureDetector(
          onPanUpdate: (details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);
            state(() {
              paints.last.sPoint.add(localPosition);
            });
          },
          onPanStart: (details) {
            paints.add(PaintModel(
                sPoint: [],
                strokeWidth: strokeWidth,
                strokeColor: selectedColor));
          },
        ),
      );
    });
  }

  Widget _buildCanvasTool(double height) {
    return Container(
      width: 60,
      height: height,
      alignment: Alignment.center,
      child: Container(
        height: 320,
        alignment: Alignment.center,
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '取消',
                      style: MiniStyle.textTitle.copyWith(color: Colors.white),
                    ),
                  ),
                  onTap: () => back(success: false),
                ),
                GestureDetector(
                  child: Container(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.brightness_1,
                      size: 10.0,
                      color: selectedLine == 0
                          ? Colors.white
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  onTap: () {
                    if (selectedLine == 0) return;
                    selectedLine = 0;
                    setState(() {});
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.brightness_1,
                      size: 15.0,
                      color: selectedLine == 1
                          ? Colors.white
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  onTap: () {
                    if (selectedLine == 1) return;
                    selectedLine = 1;
                    setState(() {});
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 35,
                    height: 35,
                    child: Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: selectedLine == 2
                          ? Colors.white
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  onTap: () {
                    if (selectedLine == 2) return;
                    selectedLine = 2;
                    setState(() {});
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 35,
                    height: 35,
                    color: selectedColor == widget.colors[0]
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.transparent,
                    child: Icon(
                      Icons.create,
                      color: widget.colors[0],
                    ),
                  ),
                  onTap: () {
                    if (selectedColor == widget.colors[0]) return;
                    selectedColor = widget.colors[0];
                    setState(() {});
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 35,
                    height: 35,
                    color: selectedColor == widget.colors[1]
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.transparent,
                    child: Icon(
                      Icons.create,
                      color: widget.colors[1],
                    ),
                  ),
                  onTap: () {
                    if (selectedColor == widget.colors[1]) return;
                    selectedColor = widget.colors[1];

                    setState(() {});
                  },
                ),
              ],
            )),
            GestureDetector(
              child: Container(
                height: 40,
                child: Text('重绘',
                    style:
                        MiniStyle.textTitle.copyWith(color: Colors.pinkAccent)),
              ),
              onTap: () {
                setState(() {
                  reset();
                });
              },
            ),
            GestureDetector(
              child: Container(
                height: 40,
                child: Text('确认',
                    style: MiniStyle.textTitle.copyWith(color: Colors.white)),
              ),
              onTap: () {
                showLoadingDialog(context);
                RenderRepaintBoundary boundary =
                    _repaintKey.currentContext.findRenderObject();
                FileUtil.capturePng2List(boundary).then((Uint8List item) {
                  pop();
                  if (item == null || item.length == 0) {
                    showMessage('绘制失败，请退出重试！', context);
                    return;
                  }
                  back(imgList: item, success: true);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransformTool(double height) {
    return Container(
      width: 50,
      height: height,
      alignment: Alignment.center,
      child: Container(
        height: 200,
        color: Colors.black54,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 35,
                height: 45,
                child: Icon(Icons.add_box, color: Colors.white),
              ),
              onTap: () {
                scale = scale + 0.1;
                setState(() {});
              },
            ),
            GestureDetector(
              child: Container(
                width: 35,
                height: 45,
                child: Icon(Icons.indeterminate_check_box, color: Colors.white),
              ),
              onTap: () {
                scale = scale - 0.1;
                setState(() {});
              },
            ),
            GestureDetector(
              child: Container(
                width: 35,
                height: 45,
                child: Icon(Icons.rotate_right, color: Colors.white),
              ),
              onTap: () {
                rotateX += pi / 2;
                setState(() {});
              },
            ),
            GestureDetector(
              child: Container(
                width: 35,
                height: 45,
                child: Icon(Icons.rotate_left, color: Colors.white),
              ),
              onTap: () {
                rotateX -= pi / 2;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  back({bool success, Uint8List imgList}) async {
    if (success == null || !success) {
      defaultDialog('返回将不保存任何内容！', onOkPressed: () {
        super.back(success: false);
      });
      return;
    }
    File scrawlImageFile = await FileUtil.saveImg(imgList, 'scrawl');
    print("图片地址：${scrawlImageFile?.path}");
    Navigator.of(context).pop(scrawlImageFile?.path);
    // Navigator.pop(context, scrawlImageFile);
  }

  void reset() {
    paints.clear();
  }

  Future<bool> onSystemBack() async {
    defaultDialog('返回将不保存任何内容！', onOkPressed: () {
      super.back(success: false);
    });
    return false;
  }
}
