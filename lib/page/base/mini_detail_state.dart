import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mixin_state.dart';

abstract class MiniDetailState<T extends StatefulWidget> extends State<T>
    with StateMixin {
  bool bottomOffstage = true;
  bool isEdited = false;
  // bool enableExit = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: bottomOffstage ? buildAppBar() : null,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        body: Stack(
          children: <Widget>[
            Container(
              color: getBackgroundColor(),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: buildBody() ?? buildLodingWidget(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Offstage(
                  child: buildBottomOffstage(), offstage: bottomOffstage),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: buildTopLayout(),
            ),
          ],
        ),
        endDrawer: buildEndDrawer(),
        bottomNavigationBar: bottomOffstage ? buildBottomAppBar() : null,
        floatingActionButton:
            bottomOffstage ? buildFloatingActionButton() : null,
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
        child: widget,
        elevation: 0);
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        brightness: Theme.of(context).appBarTheme.brightness,
        centerTitle: centerTitle(),
        leading: buildLeading(),
        title: buildTitle() ?? Text(''),
        elevation: barElevation(),
        actions: buildActions(),
      );

  double barElevation() => 0.5;

  @protected
  bool centerTitle() => true;

  @protected
  List<Widget> buildActions() => [];

  @protected
  Widget buildTitle();

  @protected
  Widget buildLeading() => null;

  @protected
  Widget buildBody();

  @protected
  Widget buildEndDrawer();

  @protected
  Widget buildNavigationButton();

  @protected
  Widget buildFloatingActionButton() => null;

  @protected
  Color getBackgroundColor() => Theme.of(context).backgroundColor;

  @protected
  Future<bool> onSystemBack() async {
    back(success: isEdited);
    return false;
  }

  @protected
  Widget buildBottomOffstage() => Container();

  @protected
  void changeBottomOffstage() {
    bottomOffstage = !bottomOffstage;
    setState(() {});
  }

  @protected
  Widget buildTopLayout() => Container();

  bool resizeToAvoidBottomInset() => true;
}
