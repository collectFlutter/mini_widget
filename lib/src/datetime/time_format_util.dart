import 'date_util.dart';
/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @Description: Timeline Util.
 * @Date: 2018/10/3
 */

///(xx)Configurable output.
///(xx)为可配置输出.
enum DayFormat {
  ///(less than 10s->just now)、x minutes、x hours、(Yesterday)、x days.
  ///(小于10s->刚刚)、x分钟、x小时、(昨天)、x天.
  Simple,

  ///(less than 10s->just now)、x minutes、x hours、[This year:(Yesterday/a day ago)、(two days age)、MM-dd ]、[past years: yyyy-MM-dd]
  ///(小于10s->刚刚)、x分钟、x小时、[今年: (昨天/1天前)、(2天前)、MM-dd],[往年: yyyy-MM-dd].
  Common,

  ///日期 + HH:mm
  ///(less than 10s->just now)、x minutes、x hours、[This year:(Yesterday HH:mm/a day ago)、(two days age)、MM-dd HH:mm]、[past years: yyyy-MM-dd HH:mm]
  ///小于10s->刚刚)、x分钟、x小时、[今年: (昨天 HH:mm/1天前)、(2天前)、MM-dd HH:mm],[往年: yyyy-MM-dd HH:mm].
  Full,
}

///Timeline information configuration.
///Timeline信息配置.
abstract class TimelineInfo {
  String suffixAgo(); //suffix ago(后缀 后).

  String suffixAfter(); //suffix after(后缀 前).

  String lessThanTenSecond() => ''; //just now(刚刚).

  String customYesterday() => ''; //Yesterday(昨天).优先级高于keepOneDay

  bool keepOneDay(); //保持1天,example: true -> 1天前, false -> MM-dd.

  bool keepTwoDays(); //保持2天,example: true -> 2天前, false -> MM-dd.

  String oneMinute(int minutes); //a minute(1分钟).

  String minutes(int minutes); //x minutes(x分钟).

  String anHour(int hours); //an hour(1小时).

  String hours(int hours); //x hours(x小时).

  String oneDay(int days); //a day(1天).

  String days(int days); //x days(x天).

}

class ZhInfo implements TimelineInfo {
  String suffixAgo() => '前';

  String suffixAfter() => '后';

  String lessThanTenSecond() => '刚刚';

  String customYesterday() => '昨天';

  bool keepOneDay() => true;

  bool keepTwoDays() => true;

  String oneMinute(int minutes) => '$minutes分钟';

  String minutes(int minutes) => '$minutes分钟';

  String anHour(int hours) => '$hours小时';

  String hours(int hours) => '$hours小时';

  String oneDay(int days) => '$days天';

  String days(int days) => '$days天';
}

class EnInfo implements TimelineInfo {
  String suffixAgo() => ' ago';

  String suffixAfter() => ' after';

  String lessThanTenSecond() => 'just now';

  String customYesterday() => 'Yesterday';

  bool keepOneDay() => true;

  bool keepTwoDays() => true;

  String oneMinute(int minutes) => 'a minute';

  String minutes(int minutes) => '$minutes minutes';

  String anHour(int hours) => 'an hour';

  String hours(int hours) => '$hours hours';

  String oneDay(int days) => 'a day';

  String days(int days) => '$days days';
}

class ZhNormalInfo implements TimelineInfo {
  String suffixAgo() => '前';

  String suffixAfter() => '后';

  String lessThanTenSecond() => '刚刚';

  String customYesterday() => '昨天';

  bool keepOneDay() => true;

  bool keepTwoDays() => false;

  String oneMinute(int minutes) => '$minutes分钟';

  String minutes(int minutes) => '$minutes分钟';

  String anHour(int hours) => '$hours小时';

  String hours(int hours) => '$hours小时';

  String oneDay(int days) => '$days天';

  String days(int days) => '$days天';
}

class EnNormalInfo implements TimelineInfo {
  String suffixAgo() => ' ago';

  String suffixAfter() => ' after';

  String lessThanTenSecond() => 'just now';

  String customYesterday() => 'Yesterday';

  bool keepOneDay() => true;

  bool keepTwoDays() => false;

  String oneMinute(int minutes) => 'a minute';

  String minutes(int minutes) => '$minutes minutes';

  String anHour(int hours) => 'an hour';

  String hours(int hours) => '$hours hours';

  String oneDay(int days) => 'a day';

  String days(int days) => '$days days';
}

Map<String, TimelineInfo> _timelineInfoMap = {
  'zh': ZhInfo(),
  'en': EnInfo(),
  'zh_normal': ZhNormalInfo(),
  //keepTwoDays() => false
  'en_normal': EnNormalInfo(),
  //keepTwoDays() => false
};

///add custom configuration.
void setLocaleInfo(String locale, TimelineInfo timelineInfo) {
  assert(locale != null, '[locale] must not be null');
  assert(timelineInfo != null, '[timelineInfo] must not be null');
  _timelineInfoMap[locale] = timelineInfo;
}

/// TimelineUtil
class TimeFormatUtil {
  /// format time by DateTime.
  /// dateTime
  /// locDateTime: current time or schedule time.
  /// locale: output key.
  static String formatByDateTime(DateTime dateTime,
      {DateTime locDateTime, String locale, DayFormat dayFormat}) {
    int _locDateTime =
    (locDateTime == null ? null : locDateTime.millisecondsSinceEpoch);
    return format(dateTime.millisecondsSinceEpoch,
        locTimeMillis: _locDateTime, locale: locale, dayFormat: dayFormat);
  }

  /// format time by millis.
  /// dateTime : millis.
  /// locDateTime: current time or schedule time. millis.
  /// locale: output key.
  static String format(int timeMillis,
      {int locTimeMillis, String locale, DayFormat dayFormat}) {
    int _locTimeMillis = locTimeMillis ?? DateTime
        .now()
        .millisecondsSinceEpoch;
    String _locale = locale ?? 'zh';
    TimelineInfo _info = _timelineInfoMap[_locale] ?? ZhInfo();
    DayFormat _dayFormat = dayFormat ?? DayFormat.Common;

    int elapsed = _locTimeMillis - timeMillis;
    String suffix;
    if (elapsed < 0) {
      elapsed = elapsed.abs();
      suffix = _info.suffixAfter();
      _dayFormat = DayFormat.Simple;
    } else {
      suffix = _info.suffixAgo();
    }

    String timeline;
    if (_info
        .customYesterday()
        .isNotEmpty &&
        DateUtil.isYesterdayByMillis(timeMillis, _locTimeMillis)) {
      return _getYesterday(timeMillis, _info, _dayFormat);
    }

    if (!DateUtil.yearIsEqualByMillis(timeMillis, _locTimeMillis)) {
      timeline = _getYear(timeMillis, _dayFormat);
      if (timeline.isNotEmpty) return timeline;
    }

    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    if (seconds < 120) {
      timeline = _info.oneMinute(1);
      if (suffix != _info.suffixAfter() &&
          _info
              .lessThanTenSecond()
              .isNotEmpty &&
          seconds < 10) {
        timeline = _info.lessThanTenSecond();
        suffix = "";
      }
    } else if (minutes < 60) {
      timeline = _info.minutes(minutes.round());
    } else if (hours < 24) {
      timeline = _info.hours(hours.round());
    } else {
      if ((days.round() == 1 && _info.keepOneDay() == true) ||
          (days.round() == 2 && _info.keepTwoDays() == true)) {
        _dayFormat = DayFormat.Simple;
      }
      timeline = _formatDays(timeMillis, days.round(), _info, _dayFormat);
      suffix = (_dayFormat == DayFormat.Simple ? suffix : "");
    }
    return timeline + suffix;
  }

  /// get Yesterday.
  /// 获取昨天.
  static String _getYesterday(int timeMillis, TimelineInfo info,
      DayFormat dayFormat) {
    return info.customYesterday() +
        (dayFormat == DayFormat.Full
            ? (" " +
            DateUtil.getDateStrByMs(timeMillis,
                format: DateFormat.HOUR_MINUTE))
            : "");
  }

  /// get is not year info.
  /// 获取非今年信息.
  static String _getYear(int timeMillis, DayFormat dayFormat) {
    if (dayFormat != DayFormat.Simple) {
      return DateUtil.getDateStrByMs(timeMillis,
          format: (dayFormat == DayFormat.Common
              ? DateFormat.YEAR_MONTH_DAY
              : DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE));
    }
    return "";
  }

  /// format Days.
  static String _formatDays(int timeMillis, num days, TimelineInfo timelineInfo,
      DayFormat dayFormat) {
    String timeline;
    switch (dayFormat) {
      case DayFormat.Simple:
        timeline = (days == 1
            ? timelineInfo.oneDay(days.round())
            : timelineInfo.days(days.round()));
        break;
      case DayFormat.Common:
        timeline =
            DateUtil.getDateStrByMs(timeMillis, format: DateFormat.MONTH_DAY);
        break;
      case DayFormat.Full:
        timeline = DateUtil.getDateStrByMs(timeMillis,
            format: DateFormat.MONTH_DAY_HOUR_MINUTE);
        break;
    }
    return timeline;
  }
}

/// 时间计算器（上月、本月、下月、本年）
class TimeTool {
  /// 当月自然月天数
  int maxMouthDays;

  /// 上一个月自然月天数
  int maxLastMouthDays;

  /// 下一个月自然月天数
  int maxNextMouthDays;

  /// 本月开始时间
  DateTime startMouthTime;

  /// 本月结束时间
  DateTime endMouthTime;

  /// 上一月开始时间
  DateTime startLastMouthTime;

  /// 上一月结束时间
  DateTime endLastMouthTime;

  /// 下一月开始时间
  DateTime startNextMouthTime;

  /// 下一月结束时间
  DateTime endNextMouthTime;

  /// 本年开始时间
  DateTime startYearTime;

  /// 本年结束
  DateTime endYearTime;

  /// 近一年年开始时间
  DateTime startNearlyYearTime;

  /// 近一年年结束时间
  DateTime endNearlyYearTime;

  /// 本周开始时间
  DateTime startWorkTime;

  /// 本周结束时间
  DateTime endWorkTime;

  /// 上一周开始时间
  DateTime startLastWorkTime;

  /// 上一周结束时间
  DateTime endLastWorkTime;

  /// 下一周开始时间
  DateTime startNextWorkTime;

  /// 下一周结束时间
  DateTime endNextWorkTime;

  /// 今日开始时间
  DateTime startDayTime;

  /// 今日结束时间
  DateTime endDayTime;

  /// 昨日开始时间
  DateTime startLastDayTime;

  /// 昨日结束时间
  DateTime endLastDayTime;

  /// 明日开始时间
  DateTime startNextDayTime;

  /// 明日结束时间
  DateTime endNextDayTime;

  /// 当前时间
  DateTime nowTime;

  TimeTool({this.nowTime}) {
    if (this.nowTime == null) {
      this.nowTime = DateTime.now();
    }
    int year = nowTime.year;
    int month = nowTime.month;
    int day = nowTime.day;

    // 本日
    this.startDayTime = DateTime(year, month, day, 0, 0, 0);
    this.endDayTime = DateTime(year, month, day, 23, 56, 56);
    // 昨日
    this.startLastDayTime = DateTime(year, month, day - 1, 0, 0, 0);
    this.endLastDayTime = DateTime(year, month, day - 1, 23, 56, 56);
    // 明日
    this.startNextDayTime = DateTime(year, month, day + 1, 0, 0, 0);
    this.endNextDayTime = DateTime(year, month, day + 1, 23, 56, 56);


    // 本周
    this.startWorkTime =
        startDayTime.subtract(Duration(days: (nowTime.weekday - 1)));
    this.endWorkTime = endDayTime.add(Duration(days: (7 - nowTime.weekday)));
    // 上周
    this.startLastWorkTime = this.startWorkTime.subtract(Duration(days: 7));
    this.endLastWorkTime = this.endWorkTime.subtract(Duration(days: 7));
    // 下周
    this.startNextWorkTime = this.startWorkTime.add(Duration(days: 7));
    this.endNextWorkTime = this.endWorkTime.add(Duration(days: 7));

    // 本年
    this.startYearTime = DateTime(year);
    this.endYearTime = DateTime(year, 12, 31, 23, 59, 59);

    // 近一年（365天)
    this.startNearlyYearTime = this.nowTime.subtract(Duration(days: 365));
    this.endNearlyYearTime = this.nowTime;

    // 本月
    this.maxMouthDays = DateUtil.getDaysInMouth(year: year, month: month);
    this.startMouthTime = DateTime(year, month);
    this.endMouthTime = DateTime(
        year,
        month,
        maxMouthDays,
        23,
        59,
        59,
        999);

    // 上一个月
    int lastYear = year;
    int lastMouth = month - 1;
    if (month == 1) {
      lastYear = year - 1;
      lastMouth = 12;
    }
    this.maxLastMouthDays =
        DateUtil.getDaysInMouth(year: lastYear, month: lastMouth);
    this.startLastMouthTime = DateTime(lastYear, lastMouth);
    this.endLastMouthTime =
        DateTime(
            lastYear,
            lastMouth,
            maxLastMouthDays,
            23,
            59,
            59,
            999);

    // 下个月
    int nextYear = year;
    int nextMouth = month + 1;
    if (month == 12) {
      nextYear = year + 1;
      nextMouth = 1;
    }
    this.maxNextMouthDays =
        DateUtil.getDaysInMouth(year: nextYear, month: nextMouth);
    this.startNextMouthTime = DateTime(nextYear, nextMouth);
    this.endNextMouthTime =
        DateTime(
            nextYear,
            nextMouth,
            maxNextMouthDays,
            23,
            59,
            59,
            999);
  }
}

class TimeModel {
  String startTime;
  String endTime;
  String timeStr;

  TimeModel({this.startTime, this.endTime, this.timeStr});

  static List<TimeModel> getTimes() {
    TimeTool timeTool = TimeTool();
    return [
      TimeModel(
          startTime: '1970-01-01 00:00:01',
          endTime: '3000-12-31 23:59:59',
          timeStr: '全部'),
      TimeModel(
          startTime: DateUtil.getDateStrByDateTime(timeTool.startDayTime),
          endTime: DateUtil.getDateStrByDateTime(timeTool.endDayTime),
          timeStr: '今日'),
      TimeModel(
          startTime: DateUtil.getDateStrByDateTime(timeTool.startWorkTime),
          endTime: DateUtil.getDateStrByDateTime(timeTool.endWorkTime),
          timeStr: '本周'),
      TimeModel(
          startTime: DateUtil.getDateStrByDateTime(timeTool.startMouthTime),
          endTime: DateUtil.getDateStrByDateTime(timeTool.endMouthTime),
          timeStr: '本月'),
      TimeModel(
          startTime: DateUtil.getDateStrByDateTime(timeTool.startLastMouthTime),
          endTime: DateUtil.getDateStrByDateTime(timeTool.endLastMouthTime),
          timeStr: '上月'),
      TimeModel(
          startTime: DateUtil.getDateStrByDateTime(timeTool.startYearTime),
          endTime: DateUtil.getDateStrByDateTime(timeTool.endYearTime),
          timeStr: '本年'),
    ];
  }
}
