import 'package:flutter/material.dart';
import 'package:mini_widget/mini_widget.dart';

Widget buildTimeLineCell(
    {String dealTime = '',
    String dealMan = '',
    String headUrl = '',
    Widget? headDefault,
    String title = '',
    String? memo,
    String? circularLabel,
    Color circularColor = Colors.blue,
    bool isState = false,
    bool isEnd = false}) {
  return Material(
    child: Ink(
      child: InkWell(
        child: Container(
          color: Colors.white,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Container(
                height: 100,
                width: 80,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Text(dealTime.getTimeStr(), style: MiniStyle.textTitle),
                    const SizedBox(height: 5),
                    Text(dealTime.getDateStr(), style: MiniStyle.textTag),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: 30,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                              height: 15,
                              width: 2,
                              color:
                                  isState ? Colors.transparent : Colors.blue),
                          Container(
                              height: 85,
                              width: 2,
                              color: isEnd ? Colors.transparent : Colors.blue),
                        ],
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: circularColor, width: 1.0),
                          color: circularColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      margin: const EdgeInsets.only(top: 2),
                      alignment: Alignment.center,
                      child: UrlUtil.isUrl(headUrl)
                          ? Image.network(headUrl)
                          : Text(circularLabel ?? '',
                              style: MiniStyle.textTag
                                  .copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, right: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        BorderWidget(label: title, fontSize: 13)
                      ]),
                      const SizedBox(height: 5),
                      Text(dealMan,
                          style: const TextStyle(
                              fontSize: MiniDimen.fontSmall,
                              height: 1.1,
                              color: MiniColor.gray)),
                      Expanded(
                          child: Text(memo ?? '',
                              style: const TextStyle(
                                  fontSize: MiniDimen.fontSmall,
                                  height: 1.1,
                                  color: MiniColor.gray))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
