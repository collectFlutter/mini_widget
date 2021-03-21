import 'package:mini_widget/mini_widget.dart';
import 'package:flutter/material.dart';

class SegmentedDemoPage extends StatefulWidget {
  @override
  _SegmentedDemoPageState createState() => _SegmentedDemoPageState();
}

class _SegmentedDemoPageState extends MiniSegmentedState<SegmentedDemoPage> {
  @override
  Widget buildTitle() {
    return Text('');
  }

  @override
  List<SegmentedModel> initSegmented() {
    return [
      SegmentedModel('Theme', ThemeWidget()),
      SegmentedModel(
          '美食', Container(child: Text('美食'), alignment: Alignment.center)),
      SegmentedModel(
          '运动', Container(child: Text('运动'), alignment: Alignment.center)),
      SegmentedModel(
          '电影', Container(child: Text('电影'), alignment: Alignment.center)),
    ];
  }
}

class ThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData data = Theme.of(context);
    double width = 60;
    return ListView(children: <Widget>[
      ListTile(
          leading: Container(color: data.backgroundColor, width: width),
          title: Text('backgroundColor')),
      ListTile(
          leading: Container(color: data.accentColor, width: width),
          title: Text('accentColor')),
      ListTile(
          leading: Container(color: data.bottomAppBarColor, width: width),
          title: Text('bottomAppBarColor')),
      ListTile(
          leading: Container(color: data.primaryColor, width: width),
          title: Text('primaryColor')),
      ListTile(
          leading: Container(color: data.primaryColorLight, width: width),
          title: Text('primaryColorLight')),
      ListTile(
          leading: Container(color: data.primaryColorDark, width: width),
          title: Text('primaryColorDark')),
      ListTile(
          leading: Container(color: data.canvasColor, width: width),
          title: Text('canvasColor')),
      ListTile(
          leading: Container(color: data.scaffoldBackgroundColor, width: width),
          title: Text('scaffoldBackgroundColor')),
      ListTile(
          leading: Container(color: data.bottomAppBarColor, width: width),
          title: Text('bottomAppBarColor')),
      ListTile(
          leading: Container(color: data.cardColor, width: width),
          title: Text('cardColor')),
      ListTile(
          leading: Container(color: data.dividerColor, width: width),
          title: Text('dividerColor')),
      ListTile(
          leading: Container(color: data.highlightColor, width: width),
          title: Text('highlightColor')),
      ListTile(
          leading: Container(color: data.splashColor, width: width),
          title: Text('splashColor')),
      ListTile(
          leading: Container(color: data.selectedRowColor, width: width),
          title: Text('selectedRowColor')),
      ListTile(
          leading: Container(color: data.unselectedWidgetColor, width: width),
          title: Text('unselectedWidgetColor ')),
      ListTile(
          leading: Container(color: data.disabledColor, width: width),
          title: Text('disabledColor ')),
      ListTile(
          leading: Container(color: data.buttonColor, width: width),
          title: Text('buttonColor ')),
      ListTile(
          leading: Container(color: data.secondaryHeaderColor, width: width),
          title: Text('secondaryHeaderColor ')),
      ListTile(
          leading: Container(color: data.textSelectionColor, width: width),
          title: Text('textSelectionColor ')),
      ListTile(
          leading: Container(color: data.cursorColor, width: width),
          title: Text('cursorColor ')),
      ListTile(
          leading:
              Container(color: data.textSelectionHandleColor, width: width),
          title: Text('textSelectionHandleColor ')),
      ListTile(
          leading: Container(color: data.dialogBackgroundColor, width: width),
          title: Text('dialogBackgroundColor ')),
      ListTile(
          leading: Container(color: data.indicatorColor, width: width),
          title: Text('indicatorColor ')),
      ListTile(
          leading: Container(color: data.hintColor, width: width),
          title: Text('hintColor')),
      ListTile(
          leading: Container(color: data.errorColor, width: width),
          title: Text('errorColor ')),
      ListTile(
          leading: Container(color: data.toggleableActiveColor, width: width),
          title: Text('toggleableActiveColor ')),
      ListTile(
          leading: Container(color: data.colorScheme.background, width: width),
          title: Text('colorScheme.background')),
      ListTile(
          leading:
              Container(color: data.colorScheme.onBackground, width: width),
          title: Text('colorScheme.onBackground')),
      ListTile(
          leading: Container(color: data.colorScheme.error, width: width),
          title: Text('colorScheme.error')),
      ListTile(
          leading: Container(color: data.colorScheme.onError, width: width),
          title: Text('colorScheme.onError')),
      ListTile(
          leading: Container(color: data.colorScheme.primary, width: width),
          title: Text('colorScheme.primary')),
      ListTile(
          leading: Container(color: data.colorScheme.onPrimary, width: width),
          title: Text('colorScheme.onPrimary')),
      ListTile(
          leading: Container(color: data.colorScheme.surface, width: width),
          title: Text('colorScheme.surface')),
      ListTile(
          leading: Container(color: data.colorScheme.onSurface, width: width),
          title: Text('colorScheme.onSurface')),
      ListTile(
          leading: Container(color: data.colorScheme.secondary, width: width),
          title: Text('colorScheme.secondary')),
      ListTile(
          leading: Container(color: data.colorScheme.onSecondary, width: width),
          title: Text('colorScheme.onSecondary')),
      ListTile(
          leading:
              Container(color: data.colorScheme.secondaryVariant, width: width),
          title: Text('colorScheme.secondaryVariant')),
      ListTile(
          leading:
              Container(color: data.colorScheme.primaryVariant, width: width),
          title: Text('colorScheme.primaryVariant')),
    ]);
  }
}
