import 'package:intl/intl.dart';

class DateTimeUtil {
  static String dateTimeToString(DateTime dateTime, String format) {
    if (dateTime == null) return null;
    var formatter = new DateFormat(format);
    return formatter.format(dateTime);
  }

  static DateTime stringToDateTime(String dateTimeString, String format) {
    if (dateTimeString == null) return null;

    var formatter = new DateFormat(format);
    return formatter.parse(dateTimeString);
  }

  static DateTime getDateTimeLaterYear(DateTime dateTime, int value) {
    return DateTime(dateTime.year + value, dateTime.month, dateTime.day);
  }

  static DateTime getDateTimeLaterDay(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day + value);
  }

  static DateTime getDateTimeLaterMonth(DateTime dateTime, int value) {
    return DateTime(dateTime.year, dateTime.month + value, dateTime.day);
  }

  static DateTime getDateTimeServer(String dateTimeString) {
    if (dateTimeString == null) return null;

    return stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss.SSSZ");
  }

  static String getDateTimeServerToHour(String dateTimeString) {
    if (dateTimeString == null) return "";
    var dateTime =
        stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss.SSSZ");
    return dateTimeToString(dateTime, "HH:mm a");
  }

  static String getDateTimeServerToDate(DateTime dateTime) {
    if (dateTime == null) return '';
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss.SSS");
  }

  static String getDateTimeSendServer(String dateTimeString) {
    var dateTime = stringToDateTime(dateTimeString, "HH:mm dd-MM-yyyy");
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss.SSS");
  }

  static String getDateTimeStringServer(DateTime dateTime) {
    return dateTimeToString(dateTime, "yyyy-MM-dd'T'HH:mm:ss");
  }

  static String getDateTimePayment(DateTime dateTime, {int hour = 0}) {
    dateTime = dateTime.subtract(new Duration(hours: hour));
    return dateTimeToString(dateTime, "dd/MM/yyyy' 'HH:mm");
  }

  static String getDateTimeInteractive(DateTime dateTime) {
    if (dateTime == null) return '';
    return ' (' + dateTimeToString(dateTime, "HH:mm '-' dd/MM/yyyy") + ')';
  }

  static String getDateTimeStamp(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return dateTimeToString(dateTime, "dd/MM/yyyy");
  }

  static String getDateTimeToDate(DateTime dateTime) {
    if (dateTime == null) return "";
    return dateTimeToString(dateTime, "dd/MM/yyyy");
  }

  static String getDateTimeFormat(DateTime dateTime, String format) {
    if (dateTime == null) return null;
    return dateTimeToString(dateTime, format);
  }

  static String getDateTimeTHG(String dateTimeString) {
    if (dateTimeString == null) return "";
    if (dateTimeString.isEmpty) return "";
    var dateTime = stringToDateTime(dateTimeString, "yyyy-MM-dd'T'HH:mm:ss");
    return getFullDate(dateTime);
  }

  static String getFullDate(DateTime dateTime) {
    return dateTime.day.toString() +
        " thg " +
        dateTime.month.toString() +
        ", " +
        dateTime.year.toString();
  }

  static String getFullTime(DateTime dateTime) {
    return dateTime.hour.toString() + " : " + dateTime.minute.toString();
  }

  static String getFullDateTime(DateTime dateTime) {
    return dateTime.day.toString() +
        " thg " +
        dateTime.month.toString() +
        ", " +
        dateTime.year.toString() +
        ", " +
        dateTimeToString(dateTime, "HH:mm:ss");
  }

  static String getFullDateTimeStringServer(String dateTimeString) {
    var dateTime = getDateTimeServer(dateTimeString);

    return getFullDateTime(dateTime);
  }

  static DateTime getDateTimeStartDay(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0, 0);
  }

  static DateTime getDateTimeEndDay(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day, 23, 59, 59, 0, 0);
  }

  static int getTimeStamp(DateTime dateTime) {
    if (dateTime == null) return null;
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    if (date1 == null && date2 == null) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static int isSameOnlyHourAndMinute(DateTime date1, DateTime date2) {
    if (date1 == null && date2 == null) {
      return 0;
    }
    if (date1 == null || date2 == null) {
      return 0;
    }
    if (date1.hour > date2.hour) {
      return 1;
    }
    if (date1.hour < date2.hour) {
      return -1;
    }
    if (date1.minute > date2.minute) {
      return 1;
    }
    if (date1.minute < date2.minute) {
      return -1;
    }
    return 0;
  }

  static int compareOnlyDay(DateTime date1, DateTime date2) {
    if (date1 == null && date2 == null) {
      return 0;
    }
    if (date1 == null || date2 == null) {
      return 0;
    }
    return getDateTimeStartDay(date1)
        .difference(getDateTimeStartDay(date2))
        .inDays;
  }

  static String getTimeMinuteFromSecond(int second) {
//    final duration = Duration(seconds: second);
//    var time = duration.toString().split('.').first.padLeft(8, '0').substring(3);
//    time = time.replaceAll(":0", "m");
//    time = time.replaceAll(":", "m") + "s";
//    time = time.replaceAll("m0s", "m");
//    return time;
    final duration = Duration(seconds: second);
    var seconds = duration.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d ');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h ');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m ');
    }
    if (seconds != 0) {
      tokens.add('${seconds}s ');
    }
    if (tokens.length == 0) {
      tokens.add('${seconds}s ');
    }

    return tokens.join('');
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  static DateTime lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1, 12)
        : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }
}
