import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_widget/mini_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _progress = 70.0;
  List<Widget> items = [];
  @override
  Widget build(BuildContext context) {
    items.clear();
    initClockWidget();
    return Scaffold(
        appBar: AppBar(title: Text("MiniWidget 测试页面")),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(children: items),
        ));
  }



  void initClockWidget() {
//    items.add(_buildItem("时钟", TimeClockPage()));
  }





  Widget _buildItem(String title, Widget widget) =>
      ListTile(title: Text(title ?? ''), onTap: () => gotoPage(widget, title));

  void gotoPage(Widget widget, String title) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => Scaffold(
              appBar: AppBar(
                title: Text(title ?? ''),
              ),
              body: widget)));
}
