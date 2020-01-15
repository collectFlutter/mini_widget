import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_widget/mini_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mini_widget demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MiniWidget 测试页面'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime datetime;
  Timer timer;
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
//    initArcWidgets(items);
//    initFiveWidgets(items);
//    initStateWidgets(items);
//    initStringWidget(items);
    initClockWidget(items);
    items.add(_buildItem(BashBoardWidget(100,strokeWidth: 5)));

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Wrap(spacing: 3, runSpacing: 3, children: items),
        ));
  }

  void initClockWidget(List<Widget> items) {
    datetime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      datetime = DateTime.now();
      setState(() {});
    });
    items.add(_buildItem(ClockWidget(datetime, height: 200, width: 200)));
  }

  void initStringWidget(List<Widget> items) {
    items.add(_buildItem(Stack(
      children: <Widget>[
        StringWidget(
          "↖",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.left,
          verticalAlign: VerticalAlign.top,
        ),
        StringWidget(
          "↑",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.center,
          verticalAlign: VerticalAlign.top,
        ),
        StringWidget(
          "↗",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.right,
          verticalAlign: VerticalAlign.top,
        ),
        StringWidget(
          "←",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.left,
          verticalAlign: VerticalAlign.center,
        ),
        StringWidget(
          "+",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.center,
          verticalAlign: VerticalAlign.center,
        ),
        StringWidget(
          "→",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.right,
          verticalAlign: VerticalAlign.center,
        ),
        StringWidget(
          "↙",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.left,
          verticalAlign: VerticalAlign.bottom,
        ),
        StringWidget(
          "↓",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.center,
          verticalAlign: VerticalAlign.bottom,
        ),
        StringWidget(
          "↘",
          width: 100,
          height: 100,
          horizontalTextAlign: TextAlign.right,
          verticalAlign: VerticalAlign.bottom,
        )
      ],
    )));
  }

  void initStateWidgets(List<Widget> items) {
    items
      ..add(_buildItem(StateWidget("进行中", color: Colors.blue, size: 60)))
      ..add(_buildItem(StateWidget("已删除", color: Colors.red, size: 100, fontSize: 18)))
      ..add(_buildItem(StateWidget("已完成", color: Colors.green, size: 180, fontSize: 38)));
  }

  void initFiveWidgets(List<Widget> items) {
    items
      ..add(_buildItem(FiveStarWidget(50)))
      ..add(_buildItem(FiveStarWidget(50, rotateAngle: 30)))
      ..add(_buildItem(FiveStarWidget(50, rotateAngle: 60, color: Colors.blue)))
      ..add(_buildItem(FiveStarWidget(50, rotateAngle: 90, color: Colors.blue)))
      ..add(_buildItem(FiveStarWidget(50, rotateAngle: 120)))
      ..add(_buildItem(FiveStarWidget(50, rotateAngle: 140)));
  }

  void initArcWidgets(List<Widget> items) {
    items
      ..add(_buildItem(ArcWidget(50, color: Colors.red)))
      ..add(_buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 90.0)))
      ..add(_buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 180.0)))
      ..add(_buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 270.0)))
      ..add(_buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 300.0, color: Colors.red)));
  }

  Widget _buildItem(Widget child) => Container(color: Colors.white, child: child);
}
