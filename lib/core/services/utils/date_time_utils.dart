part of '../utils.dart';
class DateTimeUtils {
  static String dateFormatted(String? date) {
    if (date == null) return "";
    var dt = DateTime.tryParse(date);
    if (dt == null) return date;
    return DateFormat.yMMMd().format(dt);
  }
}