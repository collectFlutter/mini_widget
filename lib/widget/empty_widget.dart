import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final Widget child;
  final String emptyImageAsset;
  final String emptyMessage;
  final Color emptyMessageColor;

  const EmptyWidget({
    Key key,
    this.emptyImageAsset,
    this.emptyMessage = '暂无内容！',
    this.child,
    this.emptyMessageColor,
  })  : assert(child != null || emptyImageAsset != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (ctx, index) =>
          child ??
          Container(
            width: double.infinity,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(emptyImageAsset, width: 100, height: 100),
                SizedBox(height: 10),
                Text(
                  emptyMessage,
                  style: TextStyle(
                    color: emptyMessageColor ??
                        Theme.of(context)
                            .textTheme
                            .bodyText2
                            .color
                            .withAlpha(100),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
