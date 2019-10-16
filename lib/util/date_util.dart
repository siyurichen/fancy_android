class DateUtil {
  static String getTimeDuration(int comTime) {
    var nowTime = DateTime.now();
    var compareTime = DateTime.fromMillisecondsSinceEpoch(comTime);
    if (nowTime.isAfter(compareTime)) {
      if (nowTime.year - compareTime.year > 0) {
        return (nowTime.year - compareTime.year).toString() + '年前';
      }
      if (nowTime.month - compareTime.month > 0) {
        return (nowTime.month - compareTime.month).toString() + '月前';
      }
      if (nowTime.day - compareTime.day > 0) {
        if ((24 - compareTime.hour + nowTime.hour) > 24) {
          return (nowTime.day - compareTime.day).toString() + '天前';
        } else {
          return (24 - compareTime.hour + nowTime.hour).toString() + '小时前';
        }
      }
      if (nowTime.hour - compareTime.hour > 0) {
        return (nowTime.hour - compareTime.hour).toString() + '小时前';
      }
      if (nowTime.minute == compareTime.minute) {
        return '片刻之间';
      }
      if (nowTime.minute - compareTime.minute > 0) {
        return (nowTime.minute - compareTime.minute).toString() + '分钟前';
      }
    }
    return 'time error';
  }

  static String getTimeDateWeek(String comTime) {
    var compareTime = DateTime.parse(comTime);
    String weekDay = '';
    switch (compareTime.weekday) {
      case 2:
        weekDay = '周二';
        break;
      case 3:
        weekDay = '周三';
        break;
      case 4:
        weekDay = '周四';
        break;
      case 5:
        weekDay = '周五';
        break;
      case 6:
        weekDay = '周六';
        break;
      case 7:
        weekDay = '周日';
        break;
      default:
        weekDay = '周一';
    }
    return '${compareTime.month}-${compareTime.day}  $weekDay';
  }
}
