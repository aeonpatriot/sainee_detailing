import 'package:intl/intl.dart';

class Utils {
  static String getDayOfWeek(DateTime date) => DateFormat('EEE').format(date);

  static String getDayOfMonth(DateTime date) => DateFormat('dd').format(date);

  static String getDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  static bool isBeforeCurrentDay(DateTime date) {
    final DateTime dateToCompare =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
    final DateTime todayDate =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    if (dateToCompare.compareTo(todayDate) == 1) {
      return false;
    } else if (dateToCompare.compareTo(todayDate) == 0) {
      return false;
    } else {
      return true;
    }
  }
}
