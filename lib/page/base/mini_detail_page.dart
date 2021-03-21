import 'package:flutter/material.dart';
import 'package:mini_tools/mini_tools.dart';
import '../../res/a.dart';

abstract class MiniDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
          color: MiniColor.background,
          alignment: Alignment.center,
          child: buildBody(context) ?? Text('正在加载数据…')),
      endDrawer: buildEndDrawer(context),
      bottomNavigationBar: buildBottomAppBar(context),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      centerTitle: true,
      title: buildTitle(context) ?? Text(''),
    );
  }

  bool isEmpty(value) => StringUtil.isEmpty(value);

  Widget buildTitle(BuildContext context);

  Widget buildBody(BuildContext context);

  Widget buildEndDrawer(BuildContext context);

  BottomAppBar buildBottomAppBar(BuildContext context) {
    Widget widget = buildNavigationButton(context);
    if (widget == null) return null;

    return BottomAppBar(
      // 底部导航
      color: MiniColor.white,
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {
                      print("base 返回");
                      back(context, success: false);
                    },
                    child: Text('返回'),
                    textColor: MiniColor.blue,
                  ),
                ],
              ),
            ),
            widget,
          ],
        ),
      ),
    );
  }

  Widget buildNavigationButton(BuildContext context);

  Widget buildFloatingActionButton(BuildContext context) {
    return null;
  }

  void back(BuildContext context, {bool success}) {
    if (isEmpty(success)) {
      Navigator.pop(context);
    } else {
      Navigator.pop(context, success);
    }
  }
}
