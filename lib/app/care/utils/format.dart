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

String formatTime(DateTime timestamp) {
  // Always convert to local time for user-friendly display
  final localTime = timestamp.toLocal();

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final date = DateTime(localTime.year, localTime.month, localTime.day);

  final timeFormat = DateFormat('hh:mm a'); // 12-hour format (e.g. 08:15 PM)

  if (date == today) {
    return timeFormat.format(localTime);
  } else if (date == yesterday) {
    return 'Yesterday, ${timeFormat.format(localTime)}';
  } else if (localTime.year == now.year) {
    return DateFormat(
      'dd MMM, hh:mm a',
    ).format(localTime); // e.g. 14 Sep, 08:15 PM
  } else {
    return DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(localTime); // e.g. 14 Sep 2024, 08:15 PM
  }
}
