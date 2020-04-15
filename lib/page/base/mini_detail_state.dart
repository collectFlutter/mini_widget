import 'dart:async';

import 'package:flutter/material.dart';

import 'mini_state.dart';

/// 详情页面父级，带返回按钮
abstract class MiniDetailState<T extends StatefulWidget> extends MiniState<T> {
  bool bottomOffstage = true;
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: bottomOffstage ? buildAppBar() : null,
        body: Stack(
          children: <Widget>[
            Container(
              color: getBackgroundColor(),
              alignment: Alignment.center,
              child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                    child: buildBody(),
                  ) ??
                  Text('正在加载数据…'),
            ),
            Positioned(
                bottom: 0, left: 0, right: 0, child: Offstage(child: buildBottomOffstage(), offstage: bottomOffstage))
          ],
        ),
        endDrawer: buildEndDrawer(),
        bottomNavigationBar: bottomOffstage ? buildBottomAppBar() : null,
        floatingActionButton: bottomOffstage ? buildFloatingActionButton() : null,
        resizeToAvoidBottomPadding: true,
        backgroundColor: getBackgroundColor(),
      ),
      onWillPop: onSystemBack,
    );
  }

  BottomAppBar buildBottomAppBar() {
    Widget widget = buildNavigationButton();
    if (widget == null) return null;
    return BottomAppBar(
      color: Theme.of(context).bottomAppBarColor,
      child: Padding(padding: EdgeInsets.only(left: 5, right: 5), child: widget),
    );
  }

  AppBar buildAppBar() => AppBar(
        brightness: Theme.of(context).appBarTheme.brightness,
        centerTitle: true,
        title: buildTitle() ?? Text(''),
      );

  Widget buildTitle();

  Widget buildBody();

  Widget buildEndDrawer();

  Widget buildNavigationButton();

  Widget buildFloatingActionButton() => null;

  Color getBackgroundColor() => Theme.of(context).backgroundColor;

  Future<bool> onSystemBack() async {
    back(success: isEdited);
    return false;
  }

  Widget buildBottomOffstage() => Container();

  void changeBottomOffstage() {
    bottomOffstage = !bottomOffstage;
    setState(() {});
  }
}
