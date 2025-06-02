import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return DateFormat('MMM yyyy').format(DateTime.now());
  }

  try {
    final date = DateTime.parse(dateString);
    return DateFormat('MMM yyyy').format(date);
  } catch (_) {
    // fallback to current date if parsing fails
    return DateFormat('MMM yyyy').format(DateTime.now());
  }
}
