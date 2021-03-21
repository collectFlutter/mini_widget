import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mini_tools/mini_tools.dart';

import 'base/mini_state.dart';
import 'base/mixin_state.dart';

class SplashPage extends StatefulWidget {
  /// 首次显示图片集合
  final List<String> firstImgUrl;

  /// 是否是首次显示
  final bool showFirst;

  /// 启动图片
  final String splashImgUrl;

  /// 结束后回调
  final ValueChanged<BuildContext> endCallback;

  /// 进入按钮名称
  final String inLabel;

  /// 动画时间，秒
  final int splashTimes;

  const SplashPage({
    Key key,
    this.firstImgUrl,
    this.showFirst = true,
    this.splashImgUrl,
    this.endCallback,
    this.inLabel = '立即体验',
    this.splashTimes = 3,
  })  : assert(showFirst != null),
        assert(splashImgUrl != null),
        super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with StateMixin {
  TimerUtil _timerUtil;
  int _status = 0;
  bool _isEnd = false;

  @override
  void initState() {
    _initSplash();
    super.initState();
  }

  @override
  void afterBuild(Duration timestamp) {
    if (widget.firstImgUrl != null && widget.firstImgUrl.length > 0) {
      widget.firstImgUrl.forEach((url) {
        precacheImage(
            UrlUtil.isUrl(url) ? NetworkImage(url) : AssetImage(url), context);
      });
    }
  }

  _initSplash() {
    _status = 1;
    _timerUtil = TimerUtil(mTotalTime: widget.splashTimes * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000.0;
      if (_tick <= 0) {
        _endSplash();
      }
    });
    _timerUtil.startCountDown();
  }

  _endSplash() {
    if (widget.showFirst &&
        widget.firstImgUrl != null &&
        widget.firstImgUrl.length > 0) {
      _status = 0;
      setState(() {});
    } else {
      _endFirst();
    }
  }

  _endFirst() {
    if (widget.endCallback != null) {
      widget.endCallback(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
//    double height = MediaQuery.of(context).size.height;
    Color color = Theme.of(context).primaryColor;

    return Material(
        child: _status == 1
            ? AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: widget.splashTimes * 1000),
                child: UrlUtil.isUrl(widget.splashImgUrl)
                    ? Image.network(widget.splashImgUrl,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: double.infinity)
                    : Image.asset(widget.splashImgUrl,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: double.infinity),
              )
            : Stack(
                children: <Widget>[
                  Swiper(
                    itemCount: widget.firstImgUrl.length,
                    loop: false,
                    itemBuilder: (_, index) {
                      String url = widget.firstImgUrl[index];
                      return UrlUtil.isUrl(url)
                          ? Image.network(url,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              height: double.infinity)
                          : Image.asset(url,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              height: double.infinity);
                    },
                    onIndexChanged: (index) {
                      _isEnd = index == widget.firstImgUrl.length - 1;
                      setState(() {});
                    },
                    pagination: _isEnd ? null : SwiperPagination(),
                  ),
                  Positioned(
                    bottom: 5,
                    child: Container(
                      width: width,
                      alignment: Alignment.bottomCenter,
                      color: Colors.transparent,
                      child: _isEnd
                          ? FlatButton(
                              textColor: color,
                              child: Text(widget.inLabel),
                              onPressed: _endFirst,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: color, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(19)),
                              ),
                            )
                          : Container(),
                    ),
                  )
                ],
              ));
  }
}
