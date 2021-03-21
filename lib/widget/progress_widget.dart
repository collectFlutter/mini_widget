import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mini_widget/mini_widget.dart';

/// 水平进度展示
class ProgressWidget extends StatelessWidget {
  final List<ProgressItemDataModel> list;
  final double itemWidth;
  final double itemHeight;

  ProgressWidget(this.list, {this.itemHeight = 70, this.itemWidth = 70})
      : assert(list != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(list.length, (index) {
        bool nextCheck = false;
        if (index < list.length - 1) {
          nextCheck = list[index + 1].checked;
        }
        return _buildItem(
          list[index],
          index == 0,
          index == list.length - 1,
          nextCheck,
          context,
        );
      }),
    );
  }

  _buildItem(ProgressItemDataModel model, bool isState, bool isEnd,
      bool nextCheck, BuildContext context) {
    return Container(
      width: itemWidth,
      height: itemHeight,
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Container(
              height: itemHeight,
              alignment: Alignment.center,
              child: GestureDetector(
                onDoubleTap: () => showMassageDialog(
                    context, model.topLabel ?? '',
                    title: model.bouutmLabel ?? ''),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 1,
                          color: isState
                              ? Colors.transparent
                              : model.checked
                                  ? Colors.blue
                                  : Colors.grey),
                    ),
                    Icon(
                      model.close
                          ? MdiIcons.closeCircle
                          : model.checked
                              ? MdiIcons.checkCircle
                              : MdiIcons.circle,
                      color: model.close
                          ? Colors.red
                          : model.checked
                              ? Colors.blue
                              : Colors.grey,
                      size: 14,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 1,
                          color: isEnd
                              ? Colors.transparent
                              : nextCheck
                                  ? Colors.blue
                                  : Colors.grey),
                    ),
                  ],
                ),
              )),
          Positioned(
            top: 0,
            child: Container(
                width: itemWidth,
                alignment: Alignment.center,
                child: Text(
                  model.topLabel,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: model.close
                          ? Colors.red
                          : model.checked
                              ? Colors.blue
                              : Colors.grey,
                      fontSize: 12),
                )),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: itemWidth,
              alignment: Alignment.center,
              child: Text(
                model.bouutmLabel,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color: model.close
                        ? Colors.red
                        : model.checked
                            ? Colors.blue
                            : Colors.grey,
                    fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProgressItemDataModel {
  /// 上部文字
  String topLabel;

  /// 下部文字
  String bouutmLabel;

  /// 是否选中
  bool checked;

  /// 是否属于关闭
  bool close;

  ProgressItemDataModel(
      {this.topLabel,
      this.bouutmLabel,
      this.checked = false,
      this.close = false});
}
