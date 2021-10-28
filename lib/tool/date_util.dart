import 'package:date_format/date_format.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/tool/num_tool.dart';

class DateUtil {
  static var weeks = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];

  ///https://www.jianshu.com/p/8af8295bf6cd
  static void logTime() {
    var time = DateTime.now();
    logDebug('time.weekday=' + time.weekday.toString());
    logDebug('time.day=' + time.day.toString());
    logDebug('time.month=' + time.month.toString());
    logDebug('time.year=' + time.year.toString());
    logDebug('time.hour=' + time.hour.toString());
    logDebug('time.minute=' + time.minute.toString());
    logDebug('time.second=' + time.second.toString());
    logDebug('time.millisecond=' + time.millisecond.toString());
    logDebug('time.millisecondsSinceEpoch=' + time.millisecondsSinceEpoch.toString());
    logDebug('time.microsecondsSinceEpoch=' + time.microsecondsSinceEpoch.toString());

    logDebug(formatDate3());
    logDebug(formatDate(time, [yyyy, '-', mm, '-', dd]));
    logDebug(formatDate(time, [yyyy, ':', mm, ':', dd, " ", HH, ':', nn, ':', ss]));
  }

  ///获取当前时间时间戳 毫秒秒级
  static int getCurTimeStamp({DateTime? date}) {
    if (date != null) {
      return date.millisecondsSinceEpoch;
    }
    return DateTime.now().millisecondsSinceEpoch;
  }

  ///获取当前时间时间戳 秒级
  static int getCurTimeStamp2({DateTime? date}) {
    if (date != null) {
      return (date.millisecondsSinceEpoch ~/ 1000).toInt();
    }
    return (DateTime.now().millisecondsSinceEpoch ~/ 1000);
  }

  /**
   * * * `"2012-02-27"`
   * * `"2012-02-27 13:27:00"`
   * * `"2012-02-27 13:27:00.123456789z"`
   * * `"2012-02-27 13:27:00,123456789z"`
   * * `"20120227 13:27:00"`
   * * `"20120227T132700"`
   * * `"20120227"`
   * * `"+20120227"`
   * * `"2012-02-27T14Z"`
   * * `"2012-02-27T14+00:00"`
   * * `"-123450101 00:00:00 Z"`: in the year -12345.
   * * `"2002-02-27T14:00:00-0500"`: Same as `"2002-02-27T19:00:00Z"`
   */

  ///解析获取时间戳 formattedString = "2012-02-27" 格式等
  static int parse(String formattedString) {
    return getCurTimeStamp2(date: DateTime.parse(formattedString));
  }

  //-------------------

  ///2020-09-11
  ///timeStamp 秒级时间戳
  static String formatDate1({int? timeStamp}) {
    final time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [yyyy, '-', mm, '-', dd]);
  }

  ///2020:09:11 09:12:21
  ///timeStamp 秒级时间戳
  static String formatDate2({int? timeStamp}) {
    final time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [yyyy, ':', mm, ':', dd, " ", HH, ':', nn, ':', ss]);
  }

  ///2020-08-24 星期一
  ///timeStamp 秒级时间戳
  static String formatDate3({int? timeStamp}) {
    final time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    var str = formatDate(time, [yyyy, '-', mm, '-', dd]) + " ${weeks[time.weekday]}";

    return str;
  }

  ///2020:09:11 09:12
  ///timeStamp 秒级时间戳
  static String formatDate4({int? timeStamp}) {
    final time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [yyyy, ':', mm, ':', dd, " ", HH, ':', nn]);
  }

  ///2020-09-11 09:12
  ///timeStamp 秒级时间戳
  static String formatDate5({int? timeStamp}) {
    final time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [yyyy, '-', mm, '-', dd, " ", HH, ':', nn]);
  }

  ///2020-09
  ///timeStamp 秒级时间戳
  static String formatDate6({int? timeStamp}) {
    var time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [yyyy, '-', mm]);
  }

  ///01-04 19:30
  ///timeStamp 秒级时间戳
  static String formatDate7({int? timeStamp}) {
    var time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [mm, '-', dd, " ", HH, ':', nn]);
  }

  ///09:12:21
  ///timeStamp 秒级时间戳
  static String formatDate8({int? timeStamp}) {
    var time = DateTime.fromMillisecondsSinceEpoch((timeStamp ?? getCurTimeStamp2()) * 1000);
    return formatDate(time, [HH, ':', nn, ':', ss]);
  }

  ///2021-03-30 09:58:49  -------注意 这个是毫秒
  ///timeStamp 毫秒级时间戳
  static String formatDate9({int? timeStamp}) {
    var time = DateTime.fromMillisecondsSinceEpoch(timeStamp ?? getCurTimeStamp2());
    return formatDate(time, [yyyy, '-', mm, '-', dd, " ", HH, ':', nn, ':', ss]);
  }

  ///解析倒计时
  /// beginTime距离现在 不超过 99小时
  static String parseCountDown({String beginTime = "2020-12-02 14:38:02"}) {
    var beginDate = DateTime.parse(beginTime);
    var change = DateTime.now().millisecondsSinceEpoch - beginDate.millisecondsSinceEpoch;
    var changeSecond = change ~/ 1000;
    int hour = changeSecond ~/ 3600;
    int minute = (changeSecond - (hour * 3600)) ~/ 60;
    int second = (changeSecond - (hour * 3600)) - (minute * 60);
    String parseStr =
        "${NumTool.doubleStr(hour)}:${NumTool.doubleStr(minute)}:${NumTool.doubleStr(second)}";
    // log("倒计时： $parseStr");
    return parseStr;
  }

  ///解析倒计时
  /// endTime 未来时间
  static String parseCountDown2({required String endTime}) {
    var endDate = DateTime.parse(endTime);
    var change = endDate.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
    var second = change ~/ 1000;
    String parseStr = "${NumTool.doubleStr(second)}s";
    // log("倒计时： $parseStr");
    return parseStr;
  }

  ///倒计时
  ///@ second 剩余秒数
  static String countDown(int second) {
    var h = 0;
    var m = 0;
    var s = 0;
    if (second >= 3600) {
      h = second ~/ 3600;
    }
    var val = second - (h * 3600);
    if (val >= 60) {
      m = val ~/ 60;
    }
    s = val - (m * 60);
    var str = "${NumTool.doubleStr(h)}:${NumTool.doubleStr(m)}:${NumTool.doubleStr(s)}";
    return str;
  }

  //--------------------------------------------------------------------------------
  //------------------------------- [自定义解析]通用显示时间 --------------------------
  //--------------------------------------------------------------------------------
  //将 unix 时间戳转换为特定时间文本，如年月日
  static String convertTime(int timestamp) {
    DateTime msgTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime nowTime = DateTime.now();

    if (nowTime.year == msgTime.year) {
      //同一年
      if (nowTime.month == msgTime.month) {
        //同一月
        if (nowTime.day == msgTime.day) {
          //同一天 时:分
          return NumTool.doubleStr(msgTime.hour) + ":" + NumTool.doubleStr(msgTime.minute);
        } else {
          if (nowTime.day - msgTime.day == 1) {
            //昨天
            return "昨天";
          } else if (nowTime.day - msgTime.day < 7) {
            return _getWeekday(msgTime.weekday);
          }
        }
      }
    }
    return msgTime.year.toString() + "/" + msgTime.month.toString() + "/" + msgTime.day.toString();
  }

  ///是否需要显示时间，相差 5 分钟
  static bool needShowTime(int sentTime1, int sentTime2) {
    return (sentTime1 - sentTime2).abs() > 5 * 60 * 1000;
  }

  static String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      default:
        return "星期日";
    }
  }

  ///根据日期，返回星座
  static String getConstellation(DateTime? birthday) {
    if (birthday == null) {
      return "未知";
    }
    final String capricorn = '摩羯座'; //Capricorn 摩羯座（12月22日～1月20日）
    final String aquarius = '水瓶座'; //Aquarius 水瓶座（1月21日～2月19日）
    final String pisces = '双鱼座'; //Pisces 双鱼座（2月20日～3月20日）
    final String aries = '白羊座'; //3月21日～4月20日
    final String taurus = '金牛座'; //4月21～5月21日
    final String gemini = '双子座'; //5月22日～6月21日
    final String cancer = '巨蟹座'; //Cancer 巨蟹座（6月22日～7月22日）
    final String leo = '狮子座'; //Leo 狮子座（7月23日～8月23日）
    final String virgo = '处女座'; //Virgo 处女座（8月24日～9月23日）
    final String libra = '天秤座'; //Libra 天秤座（9月24日～10月23日）
    final String scorpio = '天蝎座'; //Scorpio 天蝎座（10月24日～11月22日）
    final String sagittarius = '射手座'; //Sagittarius 射手座（11月23日～12月21日）

    int month = birthday.month;
    int day = birthday.day;
    String constellation = '';

    switch (month) {
      case DateTime.january:
        constellation = day < 21 ? capricorn : aquarius;
        break;
      case DateTime.february:
        constellation = day < 20 ? aquarius : pisces;
        break;
      case DateTime.march:
        constellation = day < 21 ? pisces : aries;
        break;
      case DateTime.april:
        constellation = day < 21 ? aries : taurus;
        break;
      case DateTime.may:
        constellation = day < 22 ? taurus : gemini;
        break;
      case DateTime.june:
        constellation = day < 22 ? gemini : cancer;
        break;
      case DateTime.july:
        constellation = day < 23 ? cancer : leo;
        break;
      case DateTime.august:
        constellation = day < 24 ? leo : virgo;
        break;
      case DateTime.september:
        constellation = day < 24 ? virgo : libra;
        break;
      case DateTime.october:
        constellation = day < 24 ? libra : scorpio;
        break;
      case DateTime.november:
        constellation = day < 23 ? scorpio : sagittarius;
        break;
      case DateTime.december:
        constellation = day < 22 ? sagittarius : capricorn;
        break;
    }

    return constellation;
  }

  //--------------------------------------------------------------------------------
  //------------------------------- [环信解析]通用显示时间 ----------------------------
  //--------------------------------------------------------------------------------
  //将 unix 时间戳转换为特定时间文本，如年月日
  static String convertTime2(int timestamp) {
    DateTime msgTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime nowTime = DateTime.now();

    if (nowTime.year == msgTime.year) {
      //同一年
      if (nowTime.month == msgTime.month) {
        //同一月
        if (nowTime.day == msgTime.day) {
          //同一天 时:分
          return NumTool.doubleStr(msgTime.hour) + ":" + NumTool.doubleStr(msgTime.minute);
        } else {
          if (nowTime.day - msgTime.day == 1) {
            //昨天
            return "昨天";
          } else if (nowTime.day - msgTime.day < 7) {
            return _getWeekday2(msgTime.weekday);
          }
        }
      }
    }
    return msgTime.year.toString() + "/" + msgTime.month.toString() + "/" + msgTime.day.toString();
  }

  ///是否需要显示时间，相差 5 分钟
  static bool needShowTime2(int sentTime1, int sentTime2) {
    return (sentTime1 - sentTime2).abs() > 5 * 60 * 1000;
  }

  static String _getWeekday2(int weekday) {
    switch (weekday) {
      case 1:
        return "星期一";
      case 2:
        return "星期二";
      case 3:
        return "星期三";
      case 4:
        return "星期四";
      case 5:
        return "星期五";
      case 6:
        return "星期六";
      default:
        return "星期日";
    }
  }
}
