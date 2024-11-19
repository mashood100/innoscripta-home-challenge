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

class StringUtils {
  static String cleanText(dynamic text) {
    if (text == null) return '';
    String cleanedText = text.toString();
    for (var i = 0; i < cleanedText.length; i++) {
      if (cleanedText[i] == "‘" ||
          cleanedText[i] == "’" ||
          cleanedText[i] == "'") {
        // Check for both types of quotes
        cleanedText =
            cleanedText.substring(0, i) + cleanedText.substring(i + 1);
        i--; // Adjust index since we removed a character
      }
    }
    return cleanedText;
  }
}
