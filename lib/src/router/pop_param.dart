class PopParam {
  /// 是否成功
  final bool _success;

  bool get success => _success;

  /// 携带的数据
  final dynamic _data;

  dynamic get data => _data;

  PopParam(this._success, this._data);
}
