import 'package:intl/intl.dart';

/// Formats a date string into `dd MMM yyyy` format.
///
/// Example:
/// ```dart
/// formatDateString("2025-08-14"); // "14 Aug 2025"
/// ```
String formatDateString(String? dateString, {String pattern = 'dd MMM yyyy'}) {
  if (dateString == null || dateString.isEmpty) return '';
  try {
    final date = DateTime.parse(dateString);
    return DateFormat(pattern).format(date);
  } catch (e) {
    return dateString; // Return original if parsing fails
  }
}
