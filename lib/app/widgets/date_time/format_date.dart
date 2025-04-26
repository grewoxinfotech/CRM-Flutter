import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  try {
    final date = DateTime.parse(dateString ?? '');
    return DateFormat('dd MM yyyy').format(date);
  } catch (e) {
    return DateFormat('dd MM yyyy').format(DateTime.now());
  }
}
