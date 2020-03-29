import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../res/a.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => Container(
      alignment: Alignment.center,
      color: MiniColor.black8a,
      child: SizedBox(
        height: 100,
        width: 100,
        child: Material(
          color: MiniColor.gray,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: SpinKitFadingCircle(color: Color.fromARGB(255, 233, 233, 216)),
        ),
      ),
    ),
  );
}