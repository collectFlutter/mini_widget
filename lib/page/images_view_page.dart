//图片查看
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import 'package:mini_widget/res/styles.dart';

class ImagesViewPage extends StatefulWidget {
  final int defaultIndex;
  final List<String> imgUrls;
  final double width;

  ImagesViewPage({Key key, this.defaultIndex = 0, this.imgUrls, this.width})
      : super(key: key) {
    assert(imgUrls != null);
    assert(defaultIndex >= 0 && defaultIndex < imgUrls.length);
    assert(width != null);
  }

  @override
  _PageStatus createState() => _PageStatus();
}

class _PageStatus extends State<ImagesViewPage> {
  var image;
  var w;
  var index = 1;
  var _scrollController;
  var down = 0.0; //触开始的时候的left
  var half = false; //是否超过一半

  last() {
    if (1 == index) {
    } else {
      setState(() {
        image = widget.imgUrls[index - 2];
        index = index - 1;
      });
    }
  }

  next() {
    if (widget.imgUrls.length == index) {
    } else {
      setState(() {
        image = widget.imgUrls[index];
        index = index + 1;
      });
    }
  }

  delete() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    //页面初始化
    super.initState();
    _scrollController = ScrollController(
        initialScrollOffset: widget.width * (widget.defaultIndex));
    setState(() {
      image = widget.imgUrls[widget.defaultIndex];
      index = widget.defaultIndex + 1;
    });
  }

  nextPage(w) {
    setState(() {
      index = index + 1;
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  lastPage(w) {
    setState(() {
      index = index - 1;
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  moveEnd(e, w, size) {
    var end = e.primaryVelocity;
    if (end > 10 && index > 1) {
      lastPage(w);
    } else if (end < -10 && index < size) {
      nextPage(w);
    } else if (half == true) {
      if (down > w / 2 && index < size) {
        //右边开始滑动超过一半,则下一张
        nextPage(w);
      } else if (down < w / 2 && index > 1) {
        lastPage(w);
      } else {
        _scrollController.animateTo(
          (index - 1) * w,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      }
    } else {
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  imgMove(e, w, size) {
    //down 为起点
    var left = e.position.dx;
    var now = (index - 1) * w;
    var move = left - down; //移动距离
    if (left - down > w / 2 || down - left > w / 2) {
      half = true;
    } else {
      half = false;
    }
    _scrollController.jumpTo(now - move);
  }

  Widget list(w, size) {
    List<Widget> array = [];
    widget.imgUrls.forEach((url) {
      array.add(
        Listener(
          onPointerMove: (e) => imgMove(e, w, size),
          onPointerDown: (e) => down = e.position.dx,
          child: GestureDetector(
            onHorizontalDragEnd: (e) => moveEnd(e, w, size),
            onTap: () => Navigator.pop(context),
            child: Container(
              width: w,
              child: UrlUtil.isUrl(url)
                  ? Image.network(url)
                  : Image.file(File(url)),
            ),
          ),
        ),
      );
    });
    return ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: array);
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    var size = widget.imgUrls.length;
    return Scaffold(
      body: Container(
        //        color: YeColor.white,
        child: Stack(
          children: <Widget>[
            list(w, size),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 24.0,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 35,
                color: Colors.black12,
                child: Text(
                  '$index/$size',
                  style: MiniStyle.textTitle.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
