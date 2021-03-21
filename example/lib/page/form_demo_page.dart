import 'package:flutter/material.dart';
import 'package:mini_widget/mini_widget.dart';

class FormDemoPage extends StatefulWidget {
  @override
  _FormDemoPageState createState() => _FormDemoPageState();
}

class _FormDemoPageState extends MiniDetailState<FormDemoPage> {
  TextEditingController _f1Controller;
  TextEditingController _f2Controller;
  TextEditingController _f3Controller;
  TextEditingController _f4Controller;

  final List<String> items = ['满意', '一般', '不满意'];
  List<String> images = [];
  bool selected = false;

  @override
  void initState() {
    _f1Controller = TextEditingController();
    _f2Controller = TextEditingController();
    _f3Controller = TextEditingController();
    _f4Controller = TextEditingController();
    textControllers
        .addAll([_f1Controller, _f2Controller, _f3Controller, _f4Controller]);
    super.initState();
  }

  @override
  Widget buildBody() {
    return ListView(children: <Widget>[
      buildHeadCardCell(headText: '基本信息', values: [
        EditValueModel(
            tag: 'form 1',
            controller: _f1Controller,
            inputType: TextInputType.number),
        EditValueModel(tag: 'form 2', controller: _f2Controller),
        EditValueModel(
            tag: 'form 3',
            controller: _f3Controller,
            inputType: TextInputType.emailAddress),
        buildTagSelectCell(context, '满意度',
            controller: _f4Controller, items: items, onItemSelected: (index) {
          _f4Controller.text = items[index];
        }),
        ImagesWidget(
          images,
          label: '选择照片',
          isEdit: true,
          addCallback: (path) => setState(() => images.add(path)),
          required: true,
          removeCallback: (index) => setState(() => images.removeAt(index)),
        ),
        buildTagSwitchCell(context, '开关',
            value: selected ? '开' : '关',
            selectedColor: Colors.redAccent,
            selected: selected,
            onChange: (value) => setState(() => selected = value)),
      ]),
    ]);
  }

  @override
  Widget buildEndDrawer() {
    // TODO: implement buildEndDrawer
    return null;
  }

  @override
  Widget buildNavigationButton() {
    return RaisedButton(
        onPressed: () {},
        child: Text('提交'),
        color: Colors.blue,
        textColor: Colors.white);
  }

  @override
  Widget buildTitle() => Text('表单页面');
}
