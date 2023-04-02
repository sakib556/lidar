import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String toTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static String toMonth(DateTime date) {
    return DateFormat.yMMMM().format(date);
  }

  static String toYearMonthDay(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }

  static String toMonthDay(DateTime date) {
    return DateFormat.MMMEd().format(date);
  }

  static String toDMY(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String toWholeDate(DateTime date) {
    return "${toYearMonthDay(date)} | ${toTime(date)}";
  }
}
