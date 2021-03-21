import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_widget/mini_widget.dart';

import 'page_comment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.blue),
            textTheme: TextTheme(
                title: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            elevation: 0.5,
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with StateMixin {
  List<Widget> items = [];
  @override
  void afterBuild(Duration timestamp) {
    MiniWidget.init('MiniWidget', Icon(Icons.android, color: Colors.green),
        userName: 'yshye');
  }

  @override
  Widget build(BuildContext context) {
    items.clear();
    return Scaffold(
      appBar: AppBar(title: Text("MiniWidget 测试页面")),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: pages.length * 2 - 1,
        itemBuilder: (ctx, index) {
          if (index.isOdd) return Divider(height: 2);
          return ListTile(
            title: Text(pages[index ~/ 2]['label']),
            onTap: () =>
                MiniNavigatorUtil.pushPage(context, pages[index ~/ 2]['page']),
          );
        },
      ),
    );
  }
}
