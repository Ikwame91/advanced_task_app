import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatTime(DateTime time) => DateFormat('hh:mm a').format(time);
  static String formatDate(DateTime date) => DateFormat.yMMMEd().format(date);
}
