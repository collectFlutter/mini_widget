import 'package:flutter/material.dart';

import '../widget/gzx_dropdown/_.dart';
import 'mini_detail_state.dart';

abstract class MiniDropMenuState<T extends StatefulWidget>
    extends MiniDetailState<T> {
  final List<GZXDropDownHeaderItem> _menuHeaders = [];
  final GlobalKey _stackKey = GlobalKey();
  final GZXDropdownMenuController _menuController = GZXDropdownMenuController();

  /// 获取菜单视图
  Widget getMenuWidget(int index);

  /// 修改菜单文本
  void changeMenuHeader(int index, [String? label]) {
    if (index < 0 ||
        index > _menuHeaders.length - 1 ||
        _menuHeaders[index].sort) return;
    _menuHeaders[index].title = label ?? _menuHeaders[index].title;
    setState(() {});
  }

  void hideMenu([bool showAnimation = true]) {
    if (_menuController.isShow) {
      _menuController.hide(isShowHideAnimation: showAnimation);
    }
  }

  @override
  void initState() {
    _menuHeaders
      ..clear()
      ..addAll(initMenuHeaders());
    super.initState();
  }

  /// 初始化菜单头
  List<GZXDropDownHeaderItem> initMenuHeaders();

  /// 返回每一个菜单高度
  double getDownHeight(index) => getMaxWidth() * 1.1;

  Widget buildMenuBody() {
    var headers = initMenuHeaders();
    return Stack(
      key: _stackKey,
      children: [
        Column(
          children: [
            GZXDropDownHeader(
              // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大小修改
              items: headers,
              // GZXDropDownHeader对应第一父级Stack的key
              stackKey: _stackKey,
              // controller用于控制menu的显示或隐藏
              controller: _menuController,
              // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
              onItemTap: (index) {},
              headerWidth: getMaxWidth(),
              // 头部的高度
              // height: 55,
              // 头部背景颜色
              // color: Colors.red,
              color: const Color(0xffe5ecf8),
              // 头部边框宽度
              // borderWidth: 1,
              // 头部边框颜色
              borderColor: const Color(0xFFbdc8e5),
              // 分割线高度
              dividerHeight: 1,
              // 分割线颜色
              dividerColor: const Color(0xFFbdc8e5),
              // 文字样式
              style: const TextStyle(
                color: Color(0xff7b89b4),
                fontSize: 16,
              ),
              // 下拉时文字样式
              dropDownStyle: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
              // 图标大小
              // iconSize: 20,
              // 图标颜色
              iconColor: const Color(0xFF7b89b4),
              // 下拉时图标颜色
              iconDropDownColor: Theme.of(context).primaryColor,
            ),
            ...buildContentBody()
          ],
        ),
        GZXDropDownMenu(
          // controller用于控制menu的显示或隐藏
          controller: _menuController,
          // 下拉菜单显示或隐藏动画时长
          animationMilliseconds: 100,
          // 下拉后遮罩颜色
          dropdownMenuChanging: (isShow, index) {
            setState(() {
              // _dropdownMenuChange = '(正在${isShow ? '显示' : '隐藏'}$index)';
            });
          },
          dropdownMenuChanged: (isShow, index) {
            setState(() {});
          },
          // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
          menus: List.generate(headers.length, (index) {
            return GZXDropdownMenuBuilder(
              dropDownHeight: getDownHeight(index),
              dropDownWidget: getMenuWidget(index),
            );
          }),
        ),
      ],
    );
  }

  List<Widget> buildContentBody();

  /// 可变更为主页面
  @override
  Widget buildBody() => buildMenuBody();

// @override
// bool showAppBar() => false;
}
