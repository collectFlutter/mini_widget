import 'package:flutter/material.dart';

MiniGlobal miniGlobal;

class MiniGlobal {
  String _appName;
  String get appName => _appName;

  String _userName;
  String get userName => _userName;

  Widget _appLogo;
  Widget get appLogo => _appLogo;

  MiniGlobal(this._appName, this._userName, this._appLogo);
}
