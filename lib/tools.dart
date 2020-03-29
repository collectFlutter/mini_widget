import 'package:oktoast/oktoast.dart';

String getDateStr(String time) {
  if (time == null) return '';
  if (time.length > 10) return time.substring(0, 10).replaceAll("/", "-");
  return time;
}

String getTimeStr(String time) {
  if (time == null) return '';
  if (time.length > 16) return time.substring(11, 16);
  return time;
}

/// 简单提示
void toast(String msg) => showToast(msg);