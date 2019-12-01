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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Wrap(
            spacing: 3,
            runSpacing: 3,
            children: <Widget>[
              _buildItem(FiveStarWidget(50)),
              _buildItem(FiveStarWidget(50, rotateAngle: 30)),
              _buildItem(
                  FiveStarWidget(50, rotateAngle: 60, color: Colors.blue)),
              _buildItem(
                  FiveStarWidget(50, rotateAngle: 90, color: Colors.blue)),
              _buildItem(FiveStarWidget(50, rotateAngle: 120)),
              _buildItem(FiveStarWidget(50, rotateAngle: 140)),
              _buildItem(ArcWidget(50, color: Colors.red)),
              _buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 90.0)),
              _buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 180.0)),
              _buildItem(ArcWidget(50, startAngle: 0.0, sweepAngle: 270.0)),
              _buildItem(ArcWidget(50,
                  startAngle: 0.0, sweepAngle: 300.0, color: Colors.red)),
              _buildItem(PointWidget([
                Offset(0.0, 0.0),
                Offset(0.0, 10.0),
                Offset(10.0, 10.0),
                Offset(10.0, 20.0),
                Offset(20.0, 20.0),
                Offset(20.0, 30.0),
                Offset(30.0, 30.0),
              ])),
              _buildItem(Stack(
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
              )),
              _buildItem(StringWidget(
                "待派单",
                color: Colors.blue,
                width: 100,
                height: 100,
              )),
              _buildItem(StringWidget(
                "已删除",
                color: Colors.red,
                width: 100,
                height: 100,
              )),
              _buildItem(StateWidget(
                "进行中",
                color: Colors.blue,
                size: 60,
              )),
              _buildItem(StateWidget(
                "已删除",
                color: Colors.red,
                size: 100,
                fontSize: 18,
              )),
              _buildItem(StateWidget(
                "已完成",
                color: Colors.green,
                size: 180,
                fontSize: 38,
              )),
            ],
          ),
        ));
  }

  Widget _buildItem(Widget child) =>
      Container(color: Colors.white, child: child);
}
