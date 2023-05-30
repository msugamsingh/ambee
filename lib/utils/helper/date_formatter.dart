import 'package:intl/intl.dart';

String formattedDate(DateTime dateTime, [String? formatType]) {
  final DateFormat formatter = DateFormat(formatType ?? 'MM-dd-yyyy');
  final String formatted = formatter.format(dateTime);
  return formatted;
}

class DateFormatter {
  static const DAY_DATE_MONTH = 'EEEE, d MMMM';
  static const DATE_MON_YEAR = 'dd-MM-yyyy';
  static const HOUR24 = 'H';
  static const HOUR24_MINUTE = 'Hm';
  static const SHORT_DAY = 'EEE';
}