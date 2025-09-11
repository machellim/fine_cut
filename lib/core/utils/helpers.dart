import 'package:intl/intl.dart';

class AppUtils {
  static String formatDate(DateTime timestamp) {
    return DateFormat('dd-MM-yyyy').format(timestamp);
  }

  static String formatDateTime(DateTime timestamp) {
    return DateFormat("dd-MM-yyyy HH:mm").format(timestamp);
  }

  static String formatLongDate(DateTime timestamp) {
    return DateFormat("EEE d 'de' MMMM y", "es").format(timestamp);
  }

  static String getFormatDateHour() {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy_HHmmss').format(now);
    return formattedDate;
  }

  static String formatDouble(double value, {int decimals = 2}) {
    return value.toStringAsFixed(decimals);
  }
}
