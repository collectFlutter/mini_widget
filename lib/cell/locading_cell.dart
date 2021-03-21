import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 列表加载图
Widget buildLoadingListWidget({
  Widget itemChild,
  Color baseColor = const Color(0xFFE0E0E0),
  Color highlightColor = const Color(0xFFF5F5F5),
}) {
  return ListView.builder(
    itemCount: 7,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    itemBuilder: (ctx, _) {
      return Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: itemChild ??
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 58.0, height: 58.0, color: Colors.white),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white),
                        SizedBox(height: 8.0),
                        Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white),
                        SizedBox(height: 8.0),
                        Container(
                            width: 40.0, height: 8.0, color: Colors.white),
                      ],
                    ),
                  )
                ],
              ),
            ),
      );
    },
  );
}
