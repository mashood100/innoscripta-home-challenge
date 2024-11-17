import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static DateTime? parseDate(String? dateStr) {
    if (dateStr == null) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  static String? parseAndFormateDate(String? dateStr) {
    if (dateStr == null) return "N/A";
    try {
      return formatDate(DateTime.parse(dateStr));
    } catch (e) {
      return null;
    }
  }
}
