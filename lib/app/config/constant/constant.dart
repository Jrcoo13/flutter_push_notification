import 'package:intl/intl.dart';

class AppConstant {
  //date formatter
  static String formattedDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    return formatter.format(parsedDate);
  }

  //time formatter
  static String formattedTime(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(parsedDate);
  }

  //time formatter
  static String formattedHourAndTime(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('hh:mm');
    return formatter.format(parsedDate);
  }

  //get hour date formatter
  static String getHour(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('hh');
    return formatter.format(parsedDate);
  }

  //get hour date formatter
  static String getMinutes(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('mm');
    return formatter.format(parsedDate);
  }
}
